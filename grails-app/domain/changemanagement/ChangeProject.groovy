package changemanagement
class ChangeProject {
 String projectNumber
 String title
 String description
 String status = 'OPEN'
 Date startOfProduction
 Date dateCreated
 Date lastUpdated
 static constraints = {
  projectNumber blank:false, unique:true, maxSize:80
  title blank:false, maxSize:255
  description nullable:true, maxSize:20000
  status inList:['OPEN','CLOSED']
  startOfProduction nullable:true
 }
 static mapping = { description type:'text' }
}
