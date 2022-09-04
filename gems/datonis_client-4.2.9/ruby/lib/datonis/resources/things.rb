module Datonis
	class Things < Base

		@@urlname='things'
		APISET = ['activity_summary']

		class << self
			def urlname
				@@urlname
			end

			def activity_summary(connection, attrs)
				connection.get(custom_collection_url('activity_summary'), attrs, nil)
			end
		end

	end
end
