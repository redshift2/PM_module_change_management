package changemanagement

import grails.plugin.springsecurity.annotation.Secured
import plm.PlmFreeCadPart

@Secured(['ROLE_PLM_USER','ROLE_ADMIN'])
class ChangeManagementController {
 ChangeManagementService changeManagementService
 def springSecurityService

 def index() {
  String tab = params.tab in ['projects','createDcn'] ? params.tab : 'dcn'
  String filter = params.status in ['OPEN','CLOSED'] ? params.status : 'ALL'
  [tab:tab, filter:filter, projects: filter == 'ALL' ? ChangeProject.list(sort:'projectNumber') : ChangeProject.findAllByStatus(filter,[sort:'projectNumber']),
   openProjects:ChangeProject.findAllByStatus('OPEN',[sort:'projectNumber']),
   dcns:DesignChangeNotice.list(sort:'dateCreated',order:'desc')]
 }
 def project(Long id) {
  def p = ChangeProject.get(id)
  if (!p) { response.sendError(404); return }
  def dcns = DesignChangeNotice.findAllByProject(p,[sort:'sequenceNumber'])
  def links = dcns.collectMany { DcnPart.findAllByDcn(it) }
  [project:p, dcns:dcns, links:links]
 }
 def dcn(Long id) {
  def d = DesignChangeNotice.get(id)
  if (!d) { response.sendError(404); return }
  // The PLM part.dcn field is authoritative for current DCN membership.
  // Also retain historical DcnPart links for previously associated revisions.
  List<DcnPart> recorded = DcnPart.findAllByDcn(d)
  List<PlmFreeCadPart> tagged = PlmFreeCadPart.findAllByDcn(d.dcnNumber)
  Set<Long> recordedIds = recorded.collect { it.part?.id }.findAll { it != null } as Set<Long>
  List<Map> connected = []
  recorded.each { link ->
   if (link.part) connected << [part:link.part, majorVersion:link.majorVersion, minorVersion:link.minorVersion, associationId:link.id]
  }
  tagged.each { part ->
   if (!recordedIds.contains(part.id)) {
    connected << [part:part, majorVersion:part.majorVersion, minorVersion:part.minorVersion, associationId:null]
   }
  }
  [dcn:d, connectedParts:connected, parts:PlmFreeCadPart.findAllByActive(true,[max:300,sort:'label'])]
 }
 @Secured('ROLE_ADMIN')
 def createProject() { mutate { changeManagementService.createProject(params.projectNumber,params.title,params.description,parseDate(params.startOfProduction)); redirect(controller:'changeManagement', action:'index', params:[tab:'projects']) } }
 @Secured('ROLE_ADMIN')
 def closeProject(Long id) { mutate { def p = ChangeProject.lock(id); if (!p || p.status != 'OPEN') throw new IllegalStateException('Project not open'); p.status='CLOSED'; p.save(flush:true,failOnError:true); redirect(controller:'changeManagement', action:'project', id:id) } }
 @Secured('ROLE_ADMIN')
 def createDcn() { mutate { def d = changeManagementService.createDcn(params.long('projectId'),params.title,params.description,parseDate(params.plannedReleaseDate),springSecurityService.currentUser); redirect(controller:'changeManagement', action:'dcn', id:d.id) } }
 @Secured('ROLE_ADMIN')
 def addPart(Long id) { mutate { changeManagementService.addPart(id,params.long('partId')); redirect(controller:'changeManagement', action:'dcn', id:id) } }
 @Secured('ROLE_ADMIN')
 def removePart(Long id) { mutate { changeManagementService.removePart(id,params.long('associationId')); redirect(controller:'changeManagement', action:'dcn', id:id) } }
 @Secured('ROLE_ADMIN')
 def transition(Long id) { mutate { changeManagementService.transition(id,params.target,springSecurityService.currentUser); redirect(controller:'changeManagement', action:'dcn', id:id) } }
 private Date parseDate(String value) { value ? java.sql.Date.valueOf(value) : null }
 private void mutate(Closure operation) {
  try { operation.call() } catch (Exception e) { log.warn('Change Management operation failed',e); flash.error=e.message; redirect(controller:'changeManagement', action:'index') }
 }
}
