# Aliot

Gem that allows to communicate and send endpoint data to the Datonis Platform

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aliot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aliot

## Usage

Example:
```ruby
require 'aliot/sensor'
require 'aliot/aliot_configuration'
require 'aliot/aliot_gateway_http'

#Note this will work only on linux
def get_cpu_usage
  `top -bn 2 -d 0.01 | grep '^%Cpu' | tail -n 1 | gawk '{print $2+$4+$6}'`.strip.to_f
end

def get_mem_usage
  `free | grep Mem | awk '{print $3/$2 * 100.0}'`.strip.to_f
end


s = Aliot::Sensor.new("5354ca1e4aatdd3eb44578ed519deb479ce14c4a", "MQTT-1", "MQTT", "An example MQTT based sensor", {:mem => {:type => :number}, :cpu => {:type => :number }})
c = Aliot::AliotConfiguration.new("21ff9d1f42bt55745t4a455639d3585829edc4dd", "ad33db9e2f56faab491127td944cdd47dft32d83")
g = Aliot::AliotGatewayHttp.new(c)

g.register(s)

counter = 0
while true
  if counter == 0
    # Send heart beat in between (optional)
    g.send_heart_beat(s)
  end
  g.send_data(s, {:cpu => get_cpu_usage, :mem => get_mem_usage})
  counter = (counter + 1) % 5
  sleep(5)
end
```
