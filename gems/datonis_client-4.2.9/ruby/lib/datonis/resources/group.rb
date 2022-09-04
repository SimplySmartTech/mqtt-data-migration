module Datonis
	class Group < Base

		@@urlname='groups'
		APISET = []
		class << self
			def urlname
				@@urlname
			end
  	end

  	def initialize(attrs)
			super
			things = []
			@things.each {|t| things << Datonis::Thing.new(t)} unless @things.nil?
			@things = things
		end

		def to_hash
			{group: super}
		end

		def key
			self.group_key
		end

		def things
			@things
		end

		def group_things(connection, args=nil)
			result = connection.get(custom_method_url( 'things'), nil)
			coll = Datonis::Thing.instantiate_collection(result)
			return coll
		end

	end
end