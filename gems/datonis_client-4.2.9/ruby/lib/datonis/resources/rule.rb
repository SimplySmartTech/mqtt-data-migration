module Datonis
	class Rule < Base

		@@urlname='rules'
		class << self
			def urlname
				@@urlname
			end
  	end

  	def initialize(attrs)
			super
			rules = []
			@rules.each {|r| rules << Datonis::Rule.new(r)} unless @rules.nil?
			@rules = rules
		end

		def to_hash
			{rule: super}
		end

		def key
			self.rule_key
		end

		def notification_actions(connection,args=nil)
      result = connection.get(custom_method_url('notification_actions'), nil)
      coll = Datonis::NotificationAction.instantiate_collection(result["notification_actions"])
      return coll
		end
		
		def rule_trigger_events(connection,args=nil)
      result = connection.get(custom_method_url('rule_trigger_events'), nil)
      coll = Datonis::RuleTriggerEvent.instantiate_collection(result["search_results"])
      return coll
    end
		
		def add_email_notification_action(connection,args=nil)
		  result = connection.put(custom_method_url('add_email_notification_action'),args)
		end
		
		def add_http_url_action(connection,args=nil)
      result = connection.put(custom_method_url('add_http_url_action'),args)
    end
    
    def add_sensor_traits_action(connection,args=nil)
      result = connection.put(custom_method_url('add_sensor_traits_action'),args)
    end
	end
end