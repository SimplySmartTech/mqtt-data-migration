require 'net/http'
require 'net/https'
require 'uri'
require 'aliot/aliot_util'


module Aliot
  class AliotGatewayHttp
    def initialize(config)
      @config = config
      @http = init_http_stub
    end
    
    def init_http_stub
      uri = URI(@config.url)
      http = Net::HTTP.new(uri.host, uri.port)
      if uri.scheme == "https"
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      return http
    end
    
    def encrypt_and_send_data(uri, json)
      hash = calculate_hmac_sha256(@config.secret_key, json)
      handle_response(@http.post(uri, json, {"X-Access-Key" => @config.access_key, "X-Dtn-Signature" => hash}))
    end
    
    def handle_response(response)
      puts "Response: #{response.code}"
      map_http_code(response.code)
    end
    
    def register(sensor)
      uri  = register_url(@config.url)
      json = sensor_register_json(sensor)
      puts "Registering with: #{json}"
      encrypt_and_send_data(uri, json)
    end
    
    def send_heart_beat(sensor)
      uri = heart_beat_url(@config.url)
      json = sensor_heart_beat_json(sensor)
      puts "Sending Heart Beat: #{json}"
      encrypt_and_send_data(uri, json)
    end
    
    def send_data(sensor, data, timestamp = nil)
      uri = event_url(@config.url)
      json = sensor_data_json(sensor, data, timestamp)
      puts "Sending Data: #{json}"
      encrypt_and_send_data(uri, json)
    end
    
  end 
end
