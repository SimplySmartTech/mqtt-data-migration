module Datonis
  class DatonisRole < Base
    attr_accessor :name, :abilities, :datonis_role_key, :permissions

    @@urlname='datonis_roles'
    class << self
      def urlname
        @@urlname
      end
    end

    def to_hash
      {datonis_role: super}
    end

    def key
      self.datonis_role_key
    end

    def attributes=(args)
      self.name = args[:name]
      self.abilities = args[:abilities]
      self.datonis_role_key = args[:datonis_role_key]
    end

  end
end
