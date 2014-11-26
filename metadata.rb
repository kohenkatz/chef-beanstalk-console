name             "beanstalk-console"
maintainer       "Moshe Katz"
maintainer_email "moshe@ymkatz.net"
license          "MIT"
description      "Installs Beanstalk Console"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.0"
supports         "ubuntu"

depends "php" #Actually depends on MY php cookbook!
depends "beanstalkd"
