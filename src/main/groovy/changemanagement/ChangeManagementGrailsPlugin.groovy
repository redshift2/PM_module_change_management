package changemanagement
import grails.plugins.Plugin
class ChangeManagementGrailsPlugin extends Plugin {
 def grailsVersion = '7.0.0 > *'
 def title = 'Change Management'
 def author = 'Parts Manager'
 def description = 'Projects and design change notices'
 def profiles = ['web']
 Closure doWithSpring() { { -> } }
}
