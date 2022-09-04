module DatonisHelper
  require_relative './constants.rb'
  require 'datonis_client'
  require_relative './gems/datonis_client-4.2.9/ruby/lib/datonis/api.rb'
  def connect(subdomain)
    @datonis =  Datonis::KeyBasedApi.new(
                  ACCESS_KEYS[subdomain.to_sym],
                  SENSOR_CONFIG[:api_version],
                  SENSOR_CONFIG[:url]
                )
  end

  def sensor_raw_data(subdomain, thing_key, date_range, fields, per, page)
    connect(subdomain)
    q = {
      thing_key: thing_key,
      from: date_range.first.strftime("%Y/%m/%d %H:%M:%S"),
      to: date_range.last.strftime("%Y/%m/%d %H:%M:%S"),
      metrics: fields,
      time_zone: "Mumbai",
      timestamp_format: 'int',
      per: per,
      page: page
    }

    @datonis.thing_data(q).to_h
  end
end
