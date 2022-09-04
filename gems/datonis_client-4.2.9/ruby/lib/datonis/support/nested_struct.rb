require 'ostruct'
class NestedStruct < OpenStruct

	def initialize(hash, remove_root=false)
		@table = {}
		@hash_table = {}
		hash = remove_root(hash) if remove_root
		if hash
			hash.each do |k,v|
				value = case v
				when Hash
					self.class.new(v)
				when Array
					retval = []
					v.first.is_a?(Hash) ? (v.each {|e|	retval << self.class.new(e)}) : (retval=v)
					retval
				else
					v
				end
				@table[k.to_sym] = value
				@hash_table[k] = v
				new_ostruct_member(k)
			end
		end
	end

	def to_h
		@hash_table
	end

	def remove_root(hash)
		if hash.keys.size==1
			return hash.values.first
		else
			return hash
		end
	end

end