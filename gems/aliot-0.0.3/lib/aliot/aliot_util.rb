require 'json'
require 'aliot/aliot_code'

def calculate_hmac_sha256(access_key, data)
  if RUBY_VERSION < "2.1.0"
    require 'digest/hmac'
    Digest::HMAC.hexdigest(data, access_key, Digest::SHA2)
  else
    digest = OpenSSL::Digest.new('sha256')
    hmac = OpenSSL::HMAC.hexdigest(digest, access_key, data)
  end
end

def current_timestamp_millis
  Time.now.to_i * 1000
end

def register_url(base_url)
  "#{base_url}/api/v1/sensor/register.json"
end

def event_url(base_url)
  "#{base_url}/api/v1/sensor/event.json"
end

def heart_beat_url(base_url)
  "#{base_url}/api/v1/sensor/heartbeat.json"
end

def basic_hash(message_type, timestamp = nil)
  {:type => message_type, :timestamp => (timestamp || current_timestamp_millis)}
end

def sensor_register_json(sensor)
  basic_hash(:SENSOR_REGISTER).merge({:sensor_key => sensor.thing_key, :name => sensor.name, :description => sensor.description, :type => sensor.type, :data => {:properties => sensor.metadata, :type => :object}}).to_json
end

def sensor_heart_beat_json(sensor)
  basic_hash(:SENSOR_HEARTBEAT).merge({:sensor_key => sensor.thing_key}).to_json
end

def sensor_data_hash(sensor, data, timestamp = nil)
  basic_hash(:DATA, timestamp).merge({:gateway_key => sensor.thing_key, :sensor_key => sensor.thing_key, :data => data})
end

def sensor_data_json(sensor, data, timestamp = nil)
  if (data.kind_of?(Array))
    arr = []
    data.each do |item|
      arr.shift(sensor_data_hash(sensor, data, timestamp))
    end
    basic_hash(:BULKDATA).merge(:events => arr).to_json
  else
    sensor_data_hash(sensor, data, timestamp).to_json
  end
end

def map_http_code(code)
  case code.to_i
  when 200, 202
    Aliot::AliotCode::OK
  when 401
    Aliot::AliotCode::UNAUTHORIZED
  when 406
    Aliot::AliotCode::NOT_ACCEPTABLE
  when 422
    Aliot::AliotCode::INVALID_REQUEST
  when 429
    Aliot::AliotCode::EXCESSIVE_RATE
  else
    Aliot::AliotCode::FAILED
  end
end