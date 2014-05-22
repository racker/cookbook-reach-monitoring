# encoding: UTF-8

include_recipe 'cloud_monitoring::agent'

# Attach the agent_id to the entity
cloud_monitoring_entity "#{node['fqdn']}" do
  agent_id node['cloud_monitoring']['agent']['id']
  rackspace_username node['cloud_monitoring']['rackspace_username']
  rackspace_api_key node['cloud_monitoring']['rackspace_api_key']
  action :create
end

cloud_monitoring_check 'filesystem' do
  entity_label "#{node['fqdn']}"
  type 'agent.filesystem'
  details 'target' => '/'
  period node['cloud_monitoring']['period']['agent']
  timeout node['cloud_monitoring']['timeout']['agent']
  action :create
end

cloud_monitoring_alarm 'filesystem free space alarm' do
  check_label 'filesystem'
  entity_label "#{node['fqdn']}"
  criteria BaseAlarmCriteria::filesystem_free_space_criteria(node)
  notification_plan_id node['cloud_monitoring']['notification_plan_id']
  action :create
end

cloud_monitoring_check 'cpu_stolen' do
  entity_label "#{node['fqdn']}"
  type 'agent.cpu'
  period node['cloud_monitoring']['period']['agent']
  timeout node['cloud_monitoring']['timeout']['agent']
  action :create
end

cloud_monitoring_alarm 'cpu stolen alarm' do
  check_label 'cpu_stolen'
  entity_label "#{node['fqdn']}"
  criteria BaseAlarmCriteria.with_consecutive_count(3, BaseAlarmCriteria::cpu_stolen_criteria(node))
  notification_plan_id node['cloud_monitoring']['notification_plan_id']
  action :create
end

cloud_monitoring_check 'io_wait' do
  entity_label "#{node['fqdn']}"
  type 'agent.cpu'
  period node['cloud_monitoring']['period']['agent']
  timeout node['cloud_monitoring']['timeout']['agent']
  action :create
end

cloud_monitoring_alarm 'cpu io wait alarm' do
  check_label 'io_wait'
  entity_label "#{node['fqdn']}"
  criteria BaseAlarmCriteria::cpu_io_wait_criteria(node)
  notification_plan_id node['cloud_monitoring']['notification_plan_id']
  action :create
end

cloud_monitoring_check 'memory_usage' do
  entity_label "#{node['fqdn']}"
  type 'agent.memory'
  period node['cloud_monitoring']['period']['agent']
  timeout node['cloud_monitoring']['timeout']['agent']
  action :create
end

cloud_monitoring_alarm 'memory_usage alarm' do
  check_label 'memory_usage'
  entity_label "#{node['fqdn']}"
  criteria BaseAlarmCriteria::memory_usage_criteria(node)
  notification_plan_id node['cloud_monitoring']['notification_plan_id']
  action :create
end

cloud_monitoring_check 'load_average' do
  entity_label "#{node['fqdn']}"
  type 'agent.load_average'
  period node['cloud_monitoring']['period']['agent']
  timeout node['cloud_monitoring']['timeout']['agent']
  action :create
end

cloud_monitoring_alarm 'load average alarm' do
  check_label 'load_average'
  entity_label "#{node['fqdn']}"
  criteria BaseAlarmCriteria::load_average_criteria(node)
  notification_plan_id node['cloud_monitoring']['notification_plan_id']
  action :create
end

### Remote checks

cloud_monitoring_check 'ping' do
  entity_label "#{node['fqdn']}"
  target_hostname node['ipaddress']
  type 'remote.ping'
  period node['cloud_monitoring']['period']['remote']
  timeout node['cloud_monitoring']['timeout']['remote']
  details 'count' => 5
  monitoring_zones_poll node['cloud_monitoring']['zones']
  rackspace_username node['cloud_monitoring']['rackspace_username']
  rackspace_api_key node['cloud_monitoring']['rackspace_api_key']
  action :create
end

cloud_monitoring_alarm 'ping alarm' do
  check_label 'ping'
  entity_label "#{node['fqdn']}"
  criteria BaseAlarmCriteria.with_consecutive_count(3, BaseAlarmCriteria.remote_ping_criteria)
  notification_plan_id node['cloud_monitoring']['notification_plan_id']
  action :create
end

cloud_monitoring_check 'ssh' do
  entity_label "#{node['fqdn']}"
  target_hostname node['ipaddress']
  type 'remote.ssh'
  monitoring_zones_poll node['cloud_monitoring']['zones']
  rackspace_username node['cloud_monitoring']['rackspace_username']
  rackspace_api_key node['cloud_monitoring']['rackspace_api_key']
  action :create
end

cloud_monitoring_alarm 'ssh alarm' do
  check_label 'ssh'
  entity_label "#{node['fqdn']}"
  criteria BaseAlarmCriteria.with_consecutive_count(3, BaseAlarmCriteria.remote_ssh_criteria)
  notification_plan_id node['cloud_monitoring']['notification_plan_id']
  action :create
end
