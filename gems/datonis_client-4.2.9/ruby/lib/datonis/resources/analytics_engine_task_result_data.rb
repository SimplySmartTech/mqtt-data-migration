module Datonis
  class AnalyticsEngineTaskResultData < Base
    attr_accessor :analytics_engine_task_result_key, :created_at, :updated_at, :timestamp, :data
    
    @@urlname='analytics_engine_task_result_datas'
    class << self
      def urlname
        @@urlname
      end    
    end
   
    def to_hash
      {analytics_engine_task_result_data: super}
    end

    def key
      self.analytics_engine_task_result_data_key
    end
    
    def attributes=(args)
      self.created_at = args[:created_at]
      self.updated_at = args[:updated_at]
      self.timestamp = args[:timestamp]
      self.analytics_engine_task_result_key = args[:analytics_engine_task_result_key]
      self.data = args[:data]
    end
  end
end
