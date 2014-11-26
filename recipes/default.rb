#
# Cookbook Name:: beanstalk-console
# Recipe:: default
#
# Copyright (C) 2014 Moshe Katz
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

include_recipe "php"
# This is (currently) the only PHP module we require that has a separate recipe
include_recipe "php::module_curl"

directory node['beanstalk_console']['install_path'] do
  owner node['beanstalk_console']['web_user']
  group node['beanstalk_console']['web_group']
  mode '0775'
  action :create
end

include_recipe "beanstalk-console::#{node['beanstalk_console']['install_method']}"


storage_file = File.join(node['beanstalk_console']['install_path'], 'storage.json')
file storage_file do
  owner node['beanstalk_console']['web_user']
  group node['beanstalk_console']['web_group']
  mode '0664'
  action :create
end

log_file = node['beanstalk_console']['log_file']
file log_file do
  not_if log_file.nil?
  owner node['beanstalk_console']['web_user']
  group node['beanstalk_console']['web_group']
  mode '0664'
  action :create_if_missing
end

template "/etc/init/beanstalk-console.conf" do
  source "beanstalk-console.upstart.conf.erb"
  mode 0644
  notifies :restart, "service[beanstalk-console]", :immediately
end

service "beanstalk-console" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true
  action :start
end
