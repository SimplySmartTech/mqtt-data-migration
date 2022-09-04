require 'spec_helper'

describe "DatonisQuery" do
	before(:each) do
		login('test@altizon.com', 'test123')
	end

	describe "Sensor event data" do
		
		it "returns data" do
			stub_request(:post, %r|datonis_query/sensor_event_data|).to_return(:body=> load_fixture(:sensor_event_data))
			keys = ['4fa2t52f2ecffec234b5137c23681165852ft99a', '4fa2t52f2ecffec234b5137c23681165852ft99b', '4fa2t52f2ecffec234b5137c23681165852ft99c', '4fa2t52f2ecffec234b5137c23681165852ft99d']	
			date_ranges = [{"from"=> "2014/07/2105:23:05","to"=> "2014/07/2105:38:05"}]
			attrs = {sensor_keys: keys, date_ranges: date_ranges}		
			data = @datonis.sensor_event_data(attrs)
			puts data
		end

	end

	describe "sensor event raw data" do
		it "returns raw data" do
			stub_request(:post, %r|datonis_query/sensor_event_raw_data|).to_return(:body=> load_fixture(:sensor_event_raw_data))
			key = '77421f35419c7f647d2a1f1tdaa3a84bce3tebta'
			time_format = 'str'
			per = 5
			date_ranges = [{"from"=>"2014/07/26 10:00:00", "to"=>"2014/07/26 10:15:00"}]
			attrs = {sensor_key: key, per: per, time_format: time_format, date_ranges: date_ranges}
			data = @datonis.sensor_event_raw_data(attrs)
			expect(data['total_event_count']==169).to  eq true
			expect(data.total_event_count==169).to eq true
		end
	end

	describe "search" do
		it "returns search data" do
			key = 'test'
			stub_request(:post, %r|datonis_query/search|).to_return(:body=> load_fixture(:search))
			params = {page: 1, search: key}
			results = @datonis.search(params)
			expect(results.is_a?(Array)).to  eq true
		end
	end

	describe "system summary" do
		it "get system summary" do
			stub_request(:get, %r|datonis_query/system_summary|).to_return(:body => load_fixture(:system_summary))
			results = @datonis.system_summary
			puts results
		end
	end

	describe "live feed" do
		it "get live feed" do
			stub_request(:get, %r|datonis_query/live_feed|).to_return(:body=>load_fixture(:live_feed))
			params = nil
			results = @datonis.live_feed(params)
			# puts results
		end
	end

	describe "sensors map" do
		it "returns sensor coordinates" do
			stub_request(:get, %r|datonis_query/sensors_map|).to_return(:body => load_fixture(:sensors_map))
			results = @datonis.sensors_map
			# puts results
		end
	end

end