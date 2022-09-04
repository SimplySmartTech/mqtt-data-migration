module Datonis
	class RuleTriggerEvent < Base
		@@urlname='rule_trigger_events'
		class << self
			def urlname
				@@urlname
			end
  	end

  	def initialize(attrs)
			super
			rule_trigger_events = []
			@rule_trigger_events.each {|r| rule_trigger_events << Datonis::RuleTriggerEvent.new(r)} unless @rule_trigger_events.nil?
			@rule_trigger_events = rule_trigger_events
		end

		def to_hash
			{rule_trigger_event: super}
		end

		def key
			self.rte_key
		end
	end
end