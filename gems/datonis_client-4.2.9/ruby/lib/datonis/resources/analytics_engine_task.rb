module Datonis
  class AnalyticsEngineTask < Base
    attr_accessor :analytics_engine_key, :name, :recurring, :task_recurring_frequency, :task_start_time,:task_timeout, :time_zone, :timestamp_format, :thing_keys, :thing_template_key, :group_key, :metric_keys, :additional_params, :lookback, :data_from, :data_to, :timeout_hr, :timeout_min

    @@urlname='analytics_engine_tasks'
    APISET = ['run', 'cancel']
    class << self
      def urlname
        @@urlname
      end    
    end

    def to_hash
      {analytics_engine_task: super}
    end

    def key
      self.analytics_engine_task_key
    end

    def attributes=(args)
      self.name = args[:name]
      self.recurring = args[:recurring]
      self.task_recurring_frequency = args[:task_recurring_frequency]
      self.task_start_time = args[:task_start_time]
      self.data_from = args[:data_from]
      self.data_to = args[:data_to]
      self.analytics_engine_key = args[:analytics_engine_key]
      self.analytics_engine_name = args[:analytics_engine_name]
      self.task_timeout = args[:task_timeout]
      self.time_zone = args[:time_zone]
      self.timestamp_format = args[:timestamp_format]
      self.thing_keys = args[:thing_keys]
      self.metric_keys = args[:metric_keys]
      self.group_key = args[:group_key]
      self.thing_template_key = args[:thing_template_key]
      self.additional_params = args[:additional_params]
      self.lookback = args[:lookback]
    end
    
    def timeout_hr
      self.task_timeout.to_i / 3600
    end
    
    def timeout_min
      (self.task_timeout.to_i - self.timeout_hr * 3600)/60
    end
    
    def analytics_engine_name
      self.analytics_engine_name
    end

    def run(connection, args=nil)
      connection.post(custom_method_url('run'), args[0])
    end

    def cancel(connection, args=nil)
      connection.post(custom_method_url('cancel'), args[0])
    end
  end
end
