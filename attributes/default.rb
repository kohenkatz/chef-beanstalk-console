default['beanstalk_console']['install_method'] = 'composer'
default['beanstalk_console']['install']['composer'] = 'ptrofimov/beanstalk_console'
default['beanstalk_console']['install']['git'] = 'https://github.com/ptrofimov/beanstalk_console.git'
default['beanstalk_console']['install']['tarball'] = 'https://github.com/ptrofimov/beanstalk_console/archive/master.tar.gz'
default['beanstalk_console']['install_path'] = '/opt/beanstalk_console'
# Whoever runs the webserver has to own the data file
default['beanstalk_console']['web_user'] = 'www-data'
default['beanstalk_console']['web_group'] = 'www-data'

# This command will be run in the install_path directory
default['beanstalk_console']['php_server_cmd'] = 'php -S %{ip}:%{port}'
default['beanstalk_console']['bind_ip'] = '0.0.0.0'
default['beanstalk_console']['bind_port'] = '7654'

default['beanstalk_console']['log_file'] = '/var/log/beanstalk_console.log'

default['beanstalk_console']['servers'] = [
  'localhost:11300'
]
