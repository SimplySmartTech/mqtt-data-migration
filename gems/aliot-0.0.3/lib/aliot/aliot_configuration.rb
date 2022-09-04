module Aliot
  PROTOCOL_HTTP = :http
  PROTOCOL_MQTT = :mqtt
  
  class AliotConfiguration
    attr_reader :access_key, :secret_key, :url
    
    def initialize(access_key, secret_key, protocol = PROTOCOL_HTTP, ssl = false, url = nil)
      @access_key = access_key
      @secret_key = secret_key
      
      if (url.nil?)
        if (protocol == :http)
          @url = (ssl ? "https://datonis.altizon.com" : "http://datonis.altizon.com")
        else
          @url = (ssl ? "ssl://mqtt.altizon.com:8883" : "tcp://mqtt.altizon.com:1883")
        end
      end
    end
  end
end
