package changemanagement

import grails.gorm.transactions.Transactional
import plm.PlmFreeCadPart
import plm.PlmPartLifecycleState
import plm.PlmPartLifecycleService
import crew.User

@Transactional
class ChangeManagementService {
 def serverEventService
 PlmPartLifecycleService plmPartLifecycleService

 ChangeProject createProject(String number, String title, String description, Date sop) {
  number = number?.trim()
  if (!number || !title?.trim()) throw new IllegalArgumentException('Project number and title are required')
  // A reservation survives closing, cancellation and deletion.
  new ProjectNumberReservation(projectNumber:number).save(flush:true, failOnError:true)
  new ChangeProject(projectNumber:number, title:title.trim(), description:description, startOfProduction:sop).save(flush:true, failOnError:true)
 }

 DesignChangeNotice createDcn(Long projectId, String title, String description, Date planned, User actor) {
  ChangeProject project = ChangeProject.lock(projectId)
  if (!project || project.status != 'OPEN') throw new IllegalStateException('Select an open project')
  DcnSequence sequence = DcnSequence.findByProject(project)
  if (!sequence) sequence = new DcnSequence(project:project, lastIssued:0).save(flush:true,failOnError:true)
  sequence.lastIssued++
  sequence.save(flush:true,failOnError:true)
  String number = 'A-' + project.projectNumber + '-' + String.format('%03d',sequence.lastIssued)
  DesignChangeNotice dcn = new DesignChangeNotice(project:project, sequenceNumber:sequence.lastIssued,
    dcnNumber:number, title:title?.trim(), description:description, plannedReleaseDate:planned,
    issuedBy:actor?.username).save(flush:true,failOnError:true)
  serverEventService.record('DCN_CREATE','changeManagement','DesignChangeNotice',dcn.id,actor?.username,
    'Created ' + number,[dcnNumber:number,projectNumber:project.projectNumber])
  return dcn
 }

 /** Validate a PLM metadata DCN edit before the JDBC metadata update. */
 void validatePartDcnMetadata(Long partId, String requestedNumber) {
  PlmFreeCadPart part = PlmFreeCadPart.get(partId)
  if (!part) throw new IllegalArgumentException('Part not found')
  String number = requestedNumber?.trim() ?: null
  List<DcnPart> links = DcnPart.findAllByPart(part)
  List<DcnPart> active = links.findAll { it.dcn.status in ['DRAFT','IN_REVIEW','APPROVED'] }
  if (active.any { it.dcn.status != 'DRAFT' && it.dcn.dcnNumber != number })
   throw new IllegalStateException('Cannot change DCN while the part is under review or approved')
  if (!number) return
  DesignChangeNotice dcn = DesignChangeNotice.findByDcnNumber(number)
  if (!dcn) throw new IllegalArgumentException('Unknown DCN: ' + number)
  if (dcn.status != 'DRAFT' || dcn.project.status != 'OPEN')
   throw new IllegalStateException('DCN must be a draft in an open project')
  if (part.lifecycleState != PlmPartLifecycleState.WIP || part.active != true || part.nextVersion != null)
   throw new IllegalStateException('Only active WIP part revisions can be added to a DCN')
  if (active.any { it.dcn.id != dcn.id })
   throw new IllegalStateException('Part revision already belongs to another active DCN')
 }

 /** Keep the DCN association table in sync with edits made in PLM metadata. */
 void syncPartDcnMetadata(Long partId, String requestedNumber) {
  String number = requestedNumber?.trim() ?: null
  PlmFreeCadPart part = PlmFreeCadPart.get(partId)
  if (!part) throw new IllegalArgumentException('Part not found')
  List<DcnPart> links = DcnPart.findAllByPart(part)
  links.findAll { it.dcn.status == 'DRAFT' && it.dcn.dcnNumber != number }.each {
   it.delete(flush:true)
  }
  if (number) {
   DesignChangeNotice dcn = DesignChangeNotice.findByDcnNumber(number)
   if (!DcnPart.findByDcnAndPart(dcn,part)) {
    new DcnPart(dcn:dcn,part:part,majorVersion:part.majorVersion ?: 1,
     minorVersion:part.minorVersion ?: 0).save(flush:true,failOnError:true)
   }
  }
 }

 DcnPart addPart(Long dcnId, Long partId) {
  DesignChangeNotice dcn = DesignChangeNotice.lock(dcnId)
  if (!dcn || dcn.status != 'DRAFT' || dcn.project.status != 'OPEN') throw new IllegalStateException('DCN must be an open draft')
  PlmFreeCadPart part = PlmFreeCadPart.lock(partId)
  if (!part || part.active != true || part.nextVersion != null || part.lifecycleState != PlmPartLifecycleState.WIP)
   throw new IllegalStateException('Part must be an active WIP revision')
  int major = part.majorVersion ?: 1; int minor = part.minorVersion ?: 0
  if (DcnPart.findByDcnAndPart(dcn,part)) throw new IllegalStateException('Part already on DCN')
  def conflicting = DcnPart.findAllByPart(part).find { it.majorVersion == major && it.minorVersion == minor && it.dcn.status in ['DRAFT','IN_REVIEW','APPROVED'] }
  if (conflicting) throw new IllegalStateException('Revision already belongs to active DCN ' + conflicting.dcn.dcnNumber)
  def association = new DcnPart(dcn:dcn,part:part,majorVersion:major,minorVersion:minor).save(flush:true,failOnError:true)
  part.dcn = dcn.dcnNumber
  part.save(flush:true,failOnError:true)
  association
 }

 void removePart(Long dcnId, Long associationId) {
  DesignChangeNotice dcn = DesignChangeNotice.lock(dcnId)
  if (!dcn || dcn.status != 'DRAFT') throw new IllegalStateException('DCN is locked')
  DcnPart association = DcnPart.get(associationId)
  if (!association || association.dcn.id != dcn.id) throw new IllegalArgumentException('Part association not found')
  PlmFreeCadPart part = association.part
  if (part.dcn == dcn.dcnNumber && part.majorVersion == association.majorVersion && part.minorVersion == association.minorVersion) {
   part.dcn = null; part.save(flush:true,failOnError:true)
  }
  association.delete(flush:true)
 }

 void updateDcn(Long dcnId, String title, String description, Long projectId, Date planned, User actor) {
  DesignChangeNotice dcn = DesignChangeNotice.lock(dcnId)
  if (!dcn) throw new IllegalArgumentException('DCN not found')
  if (dcn.status != 'DRAFT') throw new IllegalStateException('DCN is frozen; return it to Draft before editing')
  String cleanedTitle = title?.trim()
  if (!cleanedTitle) throw new IllegalArgumentException('Title is required')
  if (cleanedTitle.length() > 255) throw new IllegalArgumentException('Title exceeds 255 characters')
  if (description?.length() > 20000) throw new IllegalArgumentException('Description exceeds 20000 characters')
  ChangeProject project = ChangeProject.get(projectId)
  if (!project || project.status != 'OPEN') throw new IllegalArgumentException('Select an open project')
  if (project.id != dcn.project.id) {
   if (DcnPart.countByDcn(dcn) > 0) throw new IllegalStateException('Remove connected parts before changing the project')
   // DCN numbers are allocated per project. Preserve the original project and
   // issued number after creation to avoid silently invalidating references.
   throw new IllegalStateException('DCN project cannot be changed after creation')
  }
  dcn.title = cleanedTitle
  dcn.description = description
  dcn.plannedReleaseDate = planned
  dcn.save(flush:true, failOnError:true)
  serverEventService.record('DCN_UPDATE','changeManagement','DesignChangeNotice',dcn.id,actor?.username,
    'Updated ' + dcn.dcnNumber,[dcnNumber:dcn.dcnNumber])
 }

 void transition(Long dcnId, String target, User actor) {
  DesignChangeNotice dcn = DesignChangeNotice.lock(dcnId)
  if (!dcn) throw new IllegalArgumentException('DCN not found')
  String from = dcn.status
  Map allowed = [DRAFT:['IN_REVIEW','CANCELLED'], IN_REVIEW:['DRAFT','APPROVED','CANCELLED'], APPROVED:['RELEASED']]
  if (!(target in (allowed[from] ?: []))) throw new IllegalStateException('Invalid DCN transition')
  // PLM metadata may assign a DCN directly to a new CAD revision.
  // The DCN page includes those parts, so the transition must reconcile them
  // with the association table before checking whether the DCN is empty.
  // Do not auto-link historical, inactive, or superseded revisions.
  if (from == 'DRAFT' && target == 'IN_REVIEW') {
   PlmFreeCadPart.findAllByDcn(dcn.dcnNumber).each { PlmFreeCadPart tagged ->
    if (tagged.active == true && tagged.nextVersion == null &&
        !DcnPart.findByDcnAndPart(dcn, tagged)) {
     new DcnPart(dcn:dcn, part:tagged,
       majorVersion:tagged.majorVersion ?: 1,
       minorVersion:tagged.minorVersion ?: 0).save(flush:true, failOnError:true)
    }
   }
  }
  List<DcnPart> links = DcnPart.findAllByDcn(dcn)
  if (target in ['IN_REVIEW','RELEASED'] && !links) throw new IllegalStateException('DCN has no connected parts')
  // Lock all parts in stable order, verify the revision has not changed, then mutate.
  List<PlmFreeCadPart> parts = links.sort { it.part.id }.collect { link ->
   PlmFreeCadPart p = PlmFreeCadPart.lock(link.part.id)
   if (!p || p.active != true || p.nextVersion != null || p.majorVersion != link.majorVersion || p.minorVersion != link.minorVersion)
    throw new IllegalStateException('Part revision changed since DCN assignment')
   p
  }
  if (from == 'DRAFT' && target == 'IN_REVIEW') {
   if (parts.any { it.lifecycleState != PlmPartLifecycleState.WIP }) throw new IllegalStateException('All parts must be WIP and checked in')
   parts.each { it.lifecycleState = PlmPartLifecycleState.IN_REVIEW; it.save(failOnError:true) }
  } else if (from == 'IN_REVIEW' && target in ['DRAFT','CANCELLED']) {
   if (parts.any { it.lifecycleState != PlmPartLifecycleState.IN_REVIEW }) throw new IllegalStateException('Part review state changed')
   parts.each { it.lifecycleState = PlmPartLifecycleState.WIP; it.save(failOnError:true) }
  } else if (target == 'RELEASED') {
   if (parts.any { it.lifecycleState != PlmPartLifecycleState.IN_REVIEW }) throw new IllegalStateException('All parts must be IN_REVIEW')
   parts.each { p ->
    p.lifecycleState = PlmPartLifecycleState.RELEASED
    p.checkedOutBy = null; p.checkedOutAt = null
    p.releasedBy = actor; p.releasedAt = new Date()
    p.save(failOnError:true)
    // DCN release must emit the same per-part event as a normal PLM release.
    // Keep the DCN release event below for the overall change notice.
    plmPartLifecycleService.plmEventBridgeService.report('PART_RELEASE', p, actor?.username,
      [cadVersion: "${p.majorVersion ?: 1}.${p.minorVersion ?: 0}",
       dcnNumber: dcn.dcnNumber, projectNumber: dcn.project.projectNumber])
   }
  }
  if (target == 'CANCELLED') {
   // Remove the cancelled DCN from active part metadata; retain DcnPart history.
   parts.each { p ->
    if (p.dcn == dcn.dcnNumber) { p.dcn = null; p.save(failOnError:true) }
   }
  }
  if (target == 'APPROVED') {
   dcn.approvedBy = actor?.username
   dcn.approvedAt = new Date()
  } else if (target == 'IN_REVIEW' && from == 'APPROVED') {
   dcn.approvedBy = null
   dcn.approvedAt = null
  }
  dcn.status = target
  dcn.save(flush:true,failOnError:true)
  if (target in ['IN_REVIEW','RELEASED']) {
   String type = target == 'IN_REVIEW' ? 'DCN_FREEZE' : 'DCN_RELEASE'
   serverEventService.record(type,'changeManagement','DesignChangeNotice',dcn.id,actor?.username,
     type + ': ' + dcn.dcnNumber,[dcnNumber:dcn.dcnNumber,projectNumber:dcn.project.projectNumber,
     partIds:parts.collect { it.id }])
  }
 }
}
