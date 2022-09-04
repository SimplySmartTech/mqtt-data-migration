module Datonis
  class DatonisFile < Base
    attr_accessor :name, :description, :type, :driver_class, :payload, :datonis_file_key
    
    @@urlname='datonis_files'
    APISET = ['new_datonis_file','update_datonis_file']
    class << self
      def urlname
        @@urlname
      end
      
      def new_datonis_file(connection, params)
        connection.start(custom_collection_url('create_datonis_file'), params)
      end
      
      def update_datonis_file(connection, params)
        connection.start_update(custom_collection_url('update_datonis_file'), params)
      end
    end

    def to_hash
      {datonis_file: super}
    end

    def key
      self.datonis_file_key
    end
    
    def attributes=(args)
      self.name = args[:name]
      self.description = args[:description]
      self.type = args[:type]
      self.driver_class = args[:driver_class]
      self.payload = args[:payload]
      self.datonis_file_key = args[:datonis_file_key]
    end
  end
end