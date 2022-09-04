module Datonis
	class NotificationAction < Base

		@@urlname='notification_actions'
		class << self
			def urlname
				@@urlname
			end
  	end

  	def initialize(attrs)
			super
			notification_actions = []
			@notification_actions.each {|r| notification_actions << Datonis::NotificationAction.new(r)} unless @notification_actions.nil?
			@notification_actions = notification_actions
		end

		def to_hash
			{notification_action: super}
		end

		def key
			self.notification_action_key
		end
	end
end