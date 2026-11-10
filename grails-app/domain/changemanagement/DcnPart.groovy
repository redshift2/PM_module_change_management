package changemanagement
import plm.PlmFreeCadPart
class DcnPart {
 DesignChangeNotice dcn
 PlmFreeCadPart part
 Integer majorVersion
 Integer minorVersion
 Date dateCreated
 static constraints = { part unique:'dcn' }
}
