#
# Cookbook Name:: jss_chef
# Recipe:: default
#
# Copyright 2016, Kitzy
#

Chef::Resource.send(:include, JSS::Helpers)

include_recipe 'apt::default'
include_recipe 'chef-vault::default'

jssversion = node['jss_chef']['jssversion']
downloadURL = node['jss_chef']['DownloadURL']
logPath = node['jss_chef']['LogPath']

apt_package 'openjdk-7-jdk' do
  action :install
end

apt_package 'tomcat7' do
  action :install
end

apt_package 'mysql-client' do
  action :install
end

service 'tomcat7' do
  supports :status => true
  action [:start, :enable]
end

directory "#{logPath}" do
  action :create
  owner 'tomcat7'
  group 'tomcat7'
  mode '0755'
end

%w( JAMFChangeManagement.log JAMFSoftwareServer.log JSSAccess.log ).each do |name|
  file "#{logPath}/#{name}" do
    action :create_if_missing
    owner 'tomcat7'
    group 'tomcat7'
    mode '0755'
  end
end

template '/var/lib/tomcat7/conf/server.xml' do
  source 'server.xml.erb'
  variables(
    maxThreads: node['jss_chef']['maxThreads']
    )
  notifies :restart, 'service[tomcat7]', :delayed
end

directory '/var/lib/tomcat7/webapps/ROOT' do
  recursive true
  action :delete
  notifies :stop, 'service[tomcat7]', :before
  not_if { jss_war_installed?("#{jssversion}") }
end

file '/var/lib/tomcat7/webapps/ROOT.war' do
  action :delete
  notifies :stop, 'service[tomcat7]', :before
  not_if { jss_war_installed?("#{jssversion}") }
end

remote_file '/var/lib/tomcat7/webapps/ROOT.war' do
  source "#{downloadURL}/#{jssversion}.war"
  owner 'tomcat7'
  group 'tomcat7'
  mode '0777'
  action :create
  not_if { jss_war_installed?("#{jssversion}") }
  notifies :restart, 'service[tomcat7]', :immediately
  notifies :run, 'ruby_block[wait for tomcat]', :immediately
end

ruby_block 'wait for tomcat' do
  action :nothing
  block do
    true until ::File.exist?('/var/lib/tomcat7/webapps/ROOT/WEB-INF/xml/DataBase.xml')
  end
end

template '/usr/share/tomcat7/bin/setenv.sh' do
  source 'setenv.sh.erb'
  variables(
    MaxMemory: node['jss_chef']['MaxMemory']
  )
  notifies :restart, 'service[tomcat7]', :delayed
end

template '/var/lib/tomcat7/webapps/ROOT/WEB-INF/xml/DataBase.xml' do
  source 'DataBase.xml.erb'
  variables(
    ServerName: node['jss_chef']['ServerName'],
    DataBaseName: node['jss_chef']['DataBaseName'],
    DataBaseUser: node['jss_chef']['DataBaseUser'],
    DataBasePassword: node['jss_chef']['DataBasePassword'],
    MaxPoolSize: node['jss_chef']['MaxPoolSize']
  )
  notifies :restart, 'service[tomcat7]', :delayed
end

template 'var/lib/tomcat7/webapps/ROOT/WEB-INF/web.xml' do
  source 'web.xml.erb'
  variables(
  sessionTimeout: node['jss_chef']['sessionTimeout']
  )
  notifies :restart, 'service[tomcat7]', :delayed
end

template 'var/lib/tomcat7/webapps/ROOT/WEB-INF/classes/log4j.properties' do
  source 'log4j.properties.erb'
  variables(
    LogPath: node['jss_chef']['LogPath']
  )
  notifies :restart, 'service[tomcat7]', :delayed
end

%w( casperDatabaseLogin casperDatabaseRestore casperDatabaseDump ).each do |name|
  cookbook_file "/usr/local/bin/#{name}" do
    source "#{name}"
    owner 'root'
    group 'admin'
    mode '0766'
  end
end
