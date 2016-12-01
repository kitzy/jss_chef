name             'jss_chef'
maintainer       'kitzy'
maintainer_email 'kitzy@kitzy.org'
source_url       'https://github.com/kitzy/jss_chef'
issues_url       "#{source_url}/issues"
license          'All rights reserved'
description      'Installs/Configures JSS'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.18'
depends          'apt'
depends          'chef-vault'
