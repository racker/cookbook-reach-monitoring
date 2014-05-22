# encoding: UTF-8

package('ruby-dev').run_action(:install)

chef_gem 'builder' do
  action :install
end

include_recipe 'cloud_monitoring::default'

node.set['cloud_monitoring']['agent']['id'] = node['fqdn']

include_recipe 'cookbook-reach-monitoring::base_checks'

cookbook_file '/root/ensure_rackspace_monitoring_agent_in_debug.sh' do
  source 'ensure_rackspace_monitoring_agent_in_debug.sh'
  owner 'root'
  group 'root'
  mode '0700'
end

cron 'ensure the agent is running in debug mode' do
  minute '*/5'
  hour '*'
  day '*'
  month '*'
  weekday '*'
  command 'sleep 1 && /root/ensure_rackspace_monitoring_agent_in_debug.sh'
  action :create
end

bash 'ensure the agent is running in debug mode' do
  user 'root'
  code '/root/ensure_rackspace_monitoring_agent_in_debug.sh'
end

bash 'make agent log visible' do
  user 'root'
  code 'chmod 755 /var/log/rackspace-monitoring-agent.log'
end
