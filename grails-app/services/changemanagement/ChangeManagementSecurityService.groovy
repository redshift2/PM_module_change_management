package changemanagement
import jakarta.annotation.PostConstruct
import org.codehaus.groovy.runtime.MethodClosure
import taack.app.TaackApp
import taack.app.TaackAppRegisterService
class ChangeManagementSecurityService {
 static lazyInit = false
 @PostConstruct void init() {
  def stream = this.class.getResourceAsStream('/changemanagement/change-management.svg')
  if (stream) {
   String svg = stream.withCloseable { new String(it.readAllBytes(),'UTF-8') }
   TaackAppRegisterService.register(new TaackApp(ChangeManagementController.&index as MethodClosure,svg))
  }
 }
}
