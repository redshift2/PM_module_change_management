package changemanagement
class DesignChangeNotice {
 ChangeProject project
 Integer sequenceNumber
 String dcnNumber
 String title
 String description
 String status = 'DRAFT'
 Date plannedReleaseDate
 Date dateCreated
 Date lastUpdated
 static constraints = {
  project nullable:false
  sequenceNumber nullable:false, min:1
  dcnNumber blank:false, unique:true, maxSize:120
  title blank:false, maxSize:255
  description nullable:true, maxSize:20000
  status inList:['DRAFT','IN_REVIEW','APPROVED','RELEASED','CANCELLED']
  plannedReleaseDate nullable:true
 }
 static mapping = { description type:'text' }
}
