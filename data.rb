require 'rubygems'
require 'bundler/setup'
$LOAD_PATH << '.'
require 'datonis_helper.rb'
require './constants.rb'

include DatonisHelper

data = sensor_raw_data("padmaj", THING_KEYS[:padmaj][0], [LAST_SYNC_AT, Time.now], FIELDS, 100, 1)

p data["event_data"]
