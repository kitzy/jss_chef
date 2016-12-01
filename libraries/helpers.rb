module JSS
  module Helpers

    def jss_war_installed?(vers)
    #  require 'pry' ; binding.pry
      if File.exist?('/var/lib/tomcat7/webapps/ROOT/WEB-INF/xml/version.xml')
        version_file = File.read('/var/lib/tomcat7/webapps/ROOT/WEB-INF/xml/version.xml')
        if (version_file =~ /<appname>jamfWebApplication/ and version_file =~ /<version>#{vers}<\/version>/)
          true
        else
          false
        end
      else
        false
      end
    end
  end
end
