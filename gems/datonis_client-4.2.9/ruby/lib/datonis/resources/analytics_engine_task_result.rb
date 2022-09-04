module Datonis
  class AnalyticsEngineTaskResult < Base
    attr_accessor :analytics_engine_task_key, :created_at, :updated_at, :status, :error_log
    
    @@urlname='analytics_engine_task_results'
    APISET = ['download_debug_log']
    class << self
      def urlname
        @@urlname
      end    
    end
   
    def to_hash
      {analytics_engine_task_result: super}
    end

    def key
      self.analytics_engine_task_result_key
    end
    
    def attributes=(args)
      self.created_at = args[:created_at]
      self.updated_at = args[:updated_at]
      self.status = args[:status]
      self.analytics_engine_task_key = args[:analytics_engine_task_key]
      self.error_log = args[:error_log]
    end

    def download_debug_log(connection, args=nil)
      connection.get(custom_method_url('debug_log'), args[0])
    end
  end
end
