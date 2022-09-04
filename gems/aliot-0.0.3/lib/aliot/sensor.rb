module Aliot
  class Sensor
    attr_reader :key, :name, :description, :type, :metadata, :thing_key
    
    def initialize(key, name, type, description, metadata)
      @key = key
      @thing_key = key
      @name = name
      @description = description
      @type = type
      @metadata = metadata
    end
  end
end

