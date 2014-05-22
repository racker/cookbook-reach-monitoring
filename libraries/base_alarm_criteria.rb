# encoding: UTF-8
class Chef::Recipe::BaseAlarmCriteria

  def self.with_consecutive_count(trigger_count, criteria_to_use)
    ":set consecutiveCount=#{trigger_count}\n" << criteria_to_use
  end

  def self.trivial_criteria(ok_message)
    return <<-EOF
      return new AlarmStatus(OK, '#{ok_message}');
    EOF
  end

  def self.service_running_criteria(content_string, raxio)
    return <<-EOF
      if (metric['service_running'] == 'no') {
        return new AlarmStatus(CRITICAL, 'Service not running. Could not find "#{content_string}". #{raxio}');
      }
      if (metric['service_running'] == 'yes') {
        return new AlarmStatus(OK, 'Service is running');
      }
    EOF
  end

  def self.remote_ping_criteria
    return <<-EOF
      if (metric['available'] < 20) {
        return new AlarmStatus(CRITICAL, 'Not responding to ping');
      }

      return new AlarmStatus(OK, 'Responding to \#{available}% of ping requests');
    EOF
  end

  def self.remote_ssh_criteria
    return <<-EOF
      if (metric['duration'] > 5000) {
        return new AlarmStatus(CRITICAL, 'ssh not responding');
      }
    EOF
  end

  def self.filesystem_free_space_criteria(node)
    warning_threshold = node['cloud_monitoring']['alarms']['filesystem_free_space']['warning']
    critical_threshold = node['cloud_monitoring']['alarms']['filesystem_free_space']['critical']

    return <<-EOF
      if (percentage(metric['used'], metric['total']) > #{critical_threshold}) {
        return new AlarmStatus(CRITICAL, 'More than #{critical_threshold}% space used.');
      }
      if (percentage(metric['used'], metric['total']) > #{warning_threshold}) {
        return new AlarmStatus(WARNING, 'More than #{warning_threshold}% space used.');
      }
      return new AlarmStatus(OK, 'Available space is below warning threshold of #{warning_threshold}%');
    EOF
  end

  def self.cpu_stolen_criteria(node)
    warning_threshold = node['cloud_monitoring']['alarms']['cpu_stolen']['warning']
    critical_threshold = node['cloud_monitoring']['alarms']['cpu_stolen']['critical']

    return <<-EOF
      if (metric['stolen_percent_average'] > #{critical_threshold}) {
        return new AlarmStatus(CRITICAL, 'CPU usage is \#{stolen_percent_average}%');
      }
      if (metric['stolen_percent_average'] > #{warning_threshold}) {
        return new AlarmStatus(WARNING, 'CPU usage is \#{stolen_percent_average}%');
      }
      return new AlarmStatus(OK, 'CPU stolen is \#{stolen_percent_average}%');
    EOF
  end

  def self.cpu_io_wait_criteria(node)
    warning_threshold = node['cloud_monitoring']['alarms']['cpu_io_wait']['warning']
    critical_threshold = node['cloud_monitoring']['alarms']['cpu_io_wait']['critical']

    return <<-EOF
      :set consecutiveCount=5
      if (metric['wait_percent_average'] > #{warning_threshold}) {
        return new AlarmStatus(CRITICAL, 'CPU IO wait is \#{wait_percent_average}%');
      }
      if (metric['wait_percent_average'] > #{critical_threshold}) {
        return new AlarmStatus(WARNING, 'CPU IO wait is \#{wait_percent_average}%');
      }
      return new AlarmStatus(OK, 'CPU IO wait is \#{wait_percent_average}%');
    EOF
  end

  def self.memory_usage_criteria(node)
    warning_threshold = node['cloud_monitoring']['alarms']['memory_usage']['warning']
    critical_threshold = node['cloud_monitoring']['alarms']['memory_usage']['critical']

    return <<-EOF
      if (percentage(metric['actual_used'], metric['total']) > #{critical_threshold}) {
        return new AlarmStatus(CRITICAL, 'Memory usage is above #{critical_threshold}%');
      }
      if (percentage(metric['actual_used'], metric['total']) > #{warning_threshold}) {
        return new AlarmStatus(WARNING, 'Memory usage is above #{warning_threshold}%');
      }
      return new AlarmStatus(OK, 'Memory usage is below #{warning_threshold}%');
    EOF

  end

  def self.load_average_criteria(node)
    warning_threshold = node['cloud_monitoring']['alarms']['load_average']['warning']
    critical_threshold = node['cloud_monitoring']['alarms']['load_average']['critical']

    return <<-EOF
      if (metric['5m'] > #{critical_threshold}) {
        return new AlarmStatus(CRITICAL, 'Load average is above #{critical_threshold}');
      }
      if (metric['5m'] > #{warning_threshold}) {
        return new AlarmStatus(WARNING, 'Load average is above #{warning_threshold}');
      }
      return new AlarmStatus(OK, 'Load average is below #{warning_threshold}');
    EOF
  end

  def self.ssl_cert_expiring_criteria(node)
    warning_threshold = node['cloud_monitoring']['alarms']['ssl_cert_expires_in']['warning']
    critical_threshold = node['cloud_monitoring']['alarms']['ssl_cert_expires_in']['critical']

    return <<-EOF
      if (metric['cert_end_in'] < #{critical_threshold}) {
        return new AlarmStatus(CRITICAL, 'Cert expires in \#{cert_end_in} seconds.');
      }
      if (metric['cert_end_in'] < #{warning_threshold}) {
        return new AlarmStatus(WARNING, 'Cert expires in \#{cert_end_in} seconds.');
      }
      return new AlarmStatus(OK, 'HTTP Certificate does not expire for another \#{cert_end_in} seconds.');
    EOF
  end
end
