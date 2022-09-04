module Datonis
  class Alert < Base

    @@urlname='alerts'
    APISET = ['latest_alert_count']
    class << self
      def urlname
        @@urlname
      end

      def latest_alert_count(connection)
        connection.get(custom_collection_url('latest_alert_count'), {skip_token_update: true},nil)
      end
    end

    def initialize(attrs)
      super
      alerts = []
      @alerts.each {|a| alerts << Datonis::Alert.new(s)} unless @alerts.nil?
      @alerts = alerts
    end

    def to_hash
      {alert: super}
    end

    def key
      self.alert_key
    end

  end
end