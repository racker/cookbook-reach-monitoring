# encoding: UTF-8

default['cloud_monitoring']['period']['ssl_check'] = 300
default['cloud_monitoring']['period']['agent'] = 30
default['cloud_monitoring']['period']['remote'] = 30

default['cloud_monitoring']['timeout']['agent'] = 10
default['cloud_monitoring']['timeout']['remote'] = 10

default['cloud_monitoring']['agent'] = 'latest'

default['cloud_monitoring']['notification_plan_id'] = nil # REQUIRED
default['cloud_monitoring']['credentials']['databag_name'] = nil # REQUIRED
default['cloud_monitoring']['credentials']['databag_item'] = nil # REQUIRED

default['cloud_monitoring']['zones'] = ['mzord', 'mzdfw', 'mzlon']

default['cloud_monitoring']['alarms']['cpu_stolen']['warning'] = 15
default['cloud_monitoring']['alarms']['cpu_stolen']['critical'] = 30
default['cloud_monitoring']['alarms']['cpu_io_wait']['warning'] = 25
default['cloud_monitoring']['alarms']['cpu_io_wait']['critical'] = 50
default['cloud_monitoring']['alarms']['memory_usage']['warning'] = 90
default['cloud_monitoring']['alarms']['memory_usage']['critical'] = 95
default['cloud_monitoring']['alarms']['filesystem_free_space']['warning'] = 70
default['cloud_monitoring']['alarms']['filesystem_free_space']['critical'] = 90
default['cloud_monitoring']['alarms']['load_average']['warning'] = 8
default['cloud_monitoring']['alarms']['load_average']['critical'] = 10
default['cloud_monitoring']['alarms']['ssl_cert_expires_in']['warning'] = 2419200
default['cloud_monitoring']['alarms']['ssl_cert_expires_in']['critical'] = 604800
