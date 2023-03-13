require 'rubygems'
require 'bundler/setup'
$LOAD_PATH << '.'
require 'datonis_helper.rb'
require 'quazar_helper.rb'
require './constants.rb'

include DatonisHelper
include QuazarHelper

subdomains = THING_KEYS.keys.collect(&:to_s)
subdomains.each do |subdomain|
  THING_KEYS[subdomain].each do |thing_key|
    data = sensor_raw_data(subdomain, thing_key, [LAST_SYNC_AT, (LAST_SYNC_AT + 1.hours)], FIELDS, 1000, 1)
    data["event_data"].each do |packet|
      data_packet = {data: packet["data"], thing_key: thing_key, access_key: "78d9fa4teebt5add59ctb86e1a286477cb147392", time_stamp: packet["timestamp"] }
      push_data(data_packet)
    end
    sleep(30)
  end
end
