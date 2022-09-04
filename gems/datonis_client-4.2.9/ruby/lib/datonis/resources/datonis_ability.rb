module Datonis
  class DatonisAbility < Base
    attr_accessor :class_name, :operation, :seqno

    @@urlname='datonis_abilities'
    class << self
      def urlname
        @@urlname
      end
    end

    def to_hash
      {datonis_ability: super}
    end

    def key
      self.datonis_ability_key
    end

    def attributes=(args)
      self.class_name = args[:class_name]
      self.operation = args[:operation]
      self.seqno = args[:seqno]
    end

  end
end
