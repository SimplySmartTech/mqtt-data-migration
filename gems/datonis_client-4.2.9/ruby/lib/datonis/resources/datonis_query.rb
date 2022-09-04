module Datonis
	class DatonisQuery < Base

		@@urlname = 'datonis_query'
		APISET = ['thing_aggregated_data', 'thing_data', 'thing_compiled_data',
			'live_feed_and_notifications', 'account_summary', 'thing_last_data', 'thing_properties']
		class << self
			def urlname
				@@urlname
			end

			def thing_compiled_data(connection, attrs)
				connection.get(custom_collection_url('thing_compiled_data'), attrs, nil)
			end

			def thing_aggregated_data(connection, attrs)
				connection.post(custom_collection_url('thing_aggregated_data'), attrs, nil)
			end

			def thing_data(connection, attrs)
			  res = connection.post(custom_collection_url('thing_data'), attrs, nil)
			  if attrs[:raw_output].present?
          res
        else
				  NestedStruct.new(res, true)
				end
			end

			def thing_last_data(connection, attrs)
			  res = connection.post(custom_collection_url('thing_data_at_timestamp'), attrs, nil)
			  if attrs[:raw_output].present?
			    res
			  else
          NestedStruct.new(res, true)
		    end
			end

			def thing_properties(connection, attrs)
				res = connection.get('/things/properties', attrs, nil)
				if attrs[:raw_output].present?
					res
				else
					NestedStruct.new(res, true)
				end
			end

			def account_summary(connection)
				connection.get(custom_collection_url('account_summary'), nil, nil)
			end

			def live_feed_and_notifications(connection)
				connection.get(custom_collection_url('live_feed_and_notifications'), nil, nil)
			end
		end
	end
end
