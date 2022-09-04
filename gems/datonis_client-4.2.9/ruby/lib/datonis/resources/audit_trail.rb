module Datonis
  class AuditTrail < Base
    attr_accessor :action_taken, :entity_type, :entity_key, :entity_name, :audit_trail_key, :old_entity_contents, :new_entity_contents, :timestamp, :user_name, :datonis_role_name

    @@urlname='audit_trails'
    class << self
      def urlname
        @@urlname
      end
    end

    def to_hash
      {audit_trail: super}
    end

    def key
      self.audit_trail_key
    end
    
    def attributes=(args)
      self.action_taken = args[:action_taken]
      self.entity_type = args[:entity_type]
      self.entity_key = args[:entity_key]
      self.entity_name = args[:entity_name]
    end

  end
end
