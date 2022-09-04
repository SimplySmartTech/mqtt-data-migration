module Datonis
  class Metric < Base
    attr_accessor :name, :description, :metric_key, :abbreviation, :data_type, :unit_of_measure, :thing_template_key

    @@urlname='metrics'
    class << self
      def urlname
        @@urlname
      end
    end

    def to_hash
      {metric: super}
    end

    def key
      self.metric_key
    end
    
    def attributes=(args)
      self.name = args[:name]
      self.data_type = args[:data_type]
      self.unit_of_measure = args[:unit_of_measure]
      self.abrreviation = args[:abbreviation]
      self.description = args[:description]
    end
    
  end
end
