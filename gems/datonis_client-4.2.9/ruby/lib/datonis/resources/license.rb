module Datonis
	class License < Base

		APISET = ['license_plan', 'license_keys', 'license_details']
		
		attr_accessor :license_key, :allow_agentless
		@@urlname='licenses'
		class << self
			def urlname
				@@urlname
			end

			def license_plan(connection)
				NestedStruct.new(connection.get(custom_collection_url('plan'), nil)).license_plan
			end

			def license_keys(connection)
				NestedStruct.new connection.get(custom_collection_url('keys'), nil)
			end

			def license_details(connection)
				NestedStruct.new(connection.get(custom_collection_url('details'), nil)).license_details
			end
		end
	end
end