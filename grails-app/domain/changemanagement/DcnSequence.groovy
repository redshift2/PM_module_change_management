package changemanagement
/** Monotonic project sequence; never reset on DCN deletion. */
class DcnSequence {
 ChangeProject project
 Integer lastIssued = 0
 static constraints = { project unique:true }
}
