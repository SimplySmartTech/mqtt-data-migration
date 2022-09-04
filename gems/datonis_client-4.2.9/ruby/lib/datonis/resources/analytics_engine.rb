module Datonis
  class AnalyticsEngine < Base
    attr_accessor :name, :description, :cmdline, :configuration, :meta_data

    @@urlname='analytics_engines'
    APISET = ['set_configuration','remove_configuration','add_files','remove_file']
    class << self
      def urlname
        @@urlname
      end
    end

    def add_files(connection, args=nil)
      connection.put(custom_method_url('add_files'), args[0], nil)
    end

    def remove_file(connection, args=nil)
      connection.put(custom_method_url('remove_files'), args[0], nil)
    end
    
    def to_hash
      {analytics_engine: super}
    end

    def key
      self.analytics_engine_key
    end
    
    def attributes=(args)
      self.name = args[:name]
      self.description = args[:description]
      self.cmdline = args[:cmdline]
    end
    
    def set_configuration(connection, args=nil)
      connection.put(custom_method_url('set_configuration'), args)
    end

    def remove_configuration(connection, args=nil)
      connection.put(custom_method_url('remove_configuration'), args)
    end
  end
end
