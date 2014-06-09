# encoding: UTF-8

package( 'libxml2-dev' ).run_action( :install )
package( 'libxslt-dev' ).run_action( :install )

# Hack to get nokogiri to build.  By default it does not have /usr/lib/libxml2 in its
# include path.  Not sure that there is a better way to do this.

link "/usr/include/libxml" do
  to "/usr/include/libxml2/libxml"
end.run_action(:create)

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
