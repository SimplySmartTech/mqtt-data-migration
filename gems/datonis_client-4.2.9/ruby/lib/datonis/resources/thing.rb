module Datonis
	class Thing < Base

		@@urlname='things'
		APISET = ['set_user_defined_properties', 'remove_user_defined_properties', 'set_waypoint', 'waypoints', 'update_thing']

		class << self
			def urlname
				@@urlname
			end
		end

    def key
      self.thing_key
    end

    def properties
      self.user_defined_properties
    end

		def set_user_defined_properties(connection, args=nil)
      connection.put(custom_method_url('set_user_defined_properties'), args[0])
    end

    def remove_user_defined_properties(connection, args=nil)
      connection.put(custom_method_url('remove_user_defined_properties'), args[0])
    end

    def set_waypoint(connection, args=nil)
      connection.put(custom_method_url('set_waypoint'), args[0])
    end

    def waypoints(connection, args=nil)
      connection.get(custom_method_url('waypoints'), args[0])
    end

    def update_thing(connection, args=nil)
      connection.put(custom_method_url(''), args[0])
    end
	end
end
