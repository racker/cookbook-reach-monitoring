# encoding: UTF-8

maintainer       'Rackspace'
maintainer_email 'cooks@lists.rackspace.com'
license          'All rights reserved'
description      'Installs/Configures Cloud Monitoring Base Checks'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

supports 'ubuntu'

depends 'cloud_monitoring'
depends 'apt'
depends 'cron'
