module Datonis
	class KeyPair < Base

    attr_accessor :datonis_role_key, :access_key, :secret_key, :key_pair_key, :enabled, :expiry_date
    @@urlname='key_pairs'

    class << self
      def urlname
        @@urlname
      end
    end

    def to_hash
      {key_pair: super}
    end

    def key
      self.key_pair_key
    end

    def attributes=(args)
      self.access_key = args[:access_key]
      self.secret_key = args[:secret_key]
      self.key_pair_key = args[:key_pair_key]
      self.datonis_role_key = args[:datonis_role_key]
      self.enabled = args[:enabled]
      self.expiry_date = args[:expiry_date]
    end
	end
end