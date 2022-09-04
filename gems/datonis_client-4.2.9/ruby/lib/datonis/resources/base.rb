module Datonis
	class Base

		attr_accessor :errors

		def initialize(attrs = {})
			ivars = attrs
			create_attrs(ivars)
		end

		def create_attrs(ivars)
			object = self.class.to_s.downcase.split('::').last
			result = ivars[object] || ivars[self.class.to_s.split('::').last.underscore] || ivars
			result.each do |k,v|
				self.class.class_eval { attr_accessor "#{k}" }
				send("#{k}=", v)
			end
		end

		
		class << self
			def list(connection, args={})
				args["timestamp_format"] = "int"
				response = connection.get("/#{self.urlname}", args)
				if response.is_a?(Array)
					instantiate_collection(response)
				else
					retval = OpenStruct.new response
					values = []
					retval.send(self.urlname).each{|x| values << self.new(x)}
					retval.send("#{self.urlname}=", values)
					retval
				end
			end

			def read(connection, args={})
				if args.class == Hash	
					instantiate_record(connection.get("/#{self.urlname}/#{args[:id]}?timestamp_format=int", args))
				else
					instantiate_record(connection.get("/#{self.urlname}/#{args}?timestamp_format=int", nil))
				end
			end

			def create(connection, args)
				instantiate_record(connection.post("/#{self.urlname}?timestamp_format=int", args, nil))
			end

			def search(connection, args)
				retval = OpenStruct.new(connection.get(custom_collection_url('search'), args))
	      values = []
	      retval.search_results.each{|s| values << self.new(s)}
	      retval.search_results = values
      	retval
			end
		end

		def destroy(connection, args=nil)
			response = connection.delete("/#{self.class.urlname}/#{self.key}",nil)
			response['success']
		end

		# def tag(connection, args)
		# 	new_record = self.class.new(connection.put(custom_method_url('tag'), args, nil))
		# 	self.tags == new_record.tags
		# end

		# def untag(connection, args)
		# 	new_record = self.class.new(connection.put(custom_method_url('untag'), args, nil))
		# 	self.tags == new_record.tags
		# end

		def save(connection, args=nil)
			response = connection.put("/#{self.class.urlname}/#{self.key}?timestamp_format=int", self.to_hash, nil)
			if response.keys.include?('errors')
				self.errors = response['errors']
				return false
			else
				return true
			end
		end

		def to_hash
			h = {}
			vars = self.instance_variables
			vars.delete(:@ivars)
			vars.each {|v| h[v.to_s.delete('@')] = self.instance_variable_get(v)}
			h
		end


		def valid?
			(self.errors and self.errors.present?) ? false : true
		end

		def custom_method_url(method)
			"/#{self.class.urlname}/#{self.key}/#{method}"
		end


		class << self
			

			def instantiate_record(attrs)
			  return nil if attrs.nil?
				self.new(attrs)
			end

			def instantiate_collection(attrs)
				coll = []
				attrs.each { |attr| coll << instantiate_record(attr) }
				return coll
			end

			def custom_collection_url(method)
				"/#{self.urlname}/#{method}"
			end
		end
	end


end