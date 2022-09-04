module Datonis
  class Instruction < Base
    attr_accessor :name, :description, :definition
    
    @@urlname='instructions'
    class << self
      def urlname
        @@urlname
      end
    end
   
    def to_hash
      {instruction: super}
    end

    def key
      self.instruction_key
    end
    
    def attributes=(args)
      self.name = args[:name]
      self.description = args[:description]
      self.definition = args[:definition]
    end
    
    def execute_instruction(connection, args=nil)
      connection.put(custom_method_url('execute'), args[0])
    end
  end
end
