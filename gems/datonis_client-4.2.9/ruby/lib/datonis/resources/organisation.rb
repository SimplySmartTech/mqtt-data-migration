module Datonis
	class Organisation < Base

		attr_accessor :license, :organisation_key, :name, :is_oem

    @@urlname='organisations'
    APISET = ['get_oauth_details', 'add_oauth_details']
    class << self
      def urlname
        @@urlname
      end

      def get_oauth_details(body, access_key, version="v3", site="https://api.datonis.io")
        prefix = "/api/#{version}"
        connection = Connection.new(site, prefix, {'X-Access-Key' => access_key}, false)
        connection.get(custom_collection_url('get_oauth_details'),body)
      end
    end

    def add_oauth_details(connection, args=nil)
      connection.put(custom_method_url('execute'), args[0])
    end

		def initialize(attrs)
			super
			@license = Datonis::License.new(@license) if @license.present?
		end
	end
end