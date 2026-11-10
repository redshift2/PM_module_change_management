package changemanagement
/** Never delete reservations, even if a project is archived or deleted. */
class ProjectNumberReservation {
 String projectNumber
 Date dateCreated
 static constraints = { projectNumber blank:false, unique:true, maxSize:80 }
}
