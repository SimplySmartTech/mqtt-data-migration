module Datonis
  class ThingTemplate < Base
    attr_accessor :name, :description, :inactive_period, :thing_template_key, :user_defined_properties

    @@urlname='thing_templates'
    class << self
      def urlname
        @@urlname
      end
    end

    def to_hash
      {thing_template: super}
    end

    def key
      self.thing_template_key
    end
    
    def attributes=(args)
      self.name = args[:name]
      self.description = args[:description]
      self.inactive_period = args[:inactive_period]
    end
    
    def set_user_defined_properties(connection, args=nil)
      connection.put(custom_method_url('set_user_defined_properties'), args[0])
    end
    
    def remove_user_defined_properties(connection, args=nil)
      connection.put(custom_method_url('remove_user_defined_properties'), args[0])
    end
    
  end
end
