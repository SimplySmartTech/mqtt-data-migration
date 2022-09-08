module QuazarHelper
  require 'net/https'
  require 'uri'
  require 'json'

  def push_data(data)
    p data.to_json
    url = URI.parse("http://65.0.106.100:33001/old_thing_data")
    headers = { "Content-Type" => 'application/json', "accesskey" => "78d9fa4teebt5add59ctb86e1a286477cb147391"}
    http = Net::HTTP.new(url.host, url.port)
    resp, data = http.post(url.path, data.to_json, headers)
    p resp, data
  end
end

