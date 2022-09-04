describe "Sensor-V2" do
	before(:each) do
		@key = 'afa2t52f2ecffec234b5137c23681165852ft99b'
		@new_attrs = {name: 'test sensor 1', description: 'testsensor'}
		login_v2('test@altizon.com', 'test123')
	end

	it "list" do
		stub_request(:get, %r|/sensors|).to_return(body: load_v2_fixture(:sensors))
		result = @datonis.all_sensors
		expect(result.is_a?(OpenStruct)).to eq true
		expect(result.total_count==2).to eq true
		expect(result.page==1).to  eq true
		expect(result.sensors.is_a?(Array)).to eq true
		expect(result.sensors.first.is_a?(Datonis::Sensor)).to  eq true
	end

	# it "show" do
	# 	stub_request(:get, %r|/sensors/#{@key}|).to_return(body: load_v2_fixture(:sensor))
	# 	sensor = @datonis.get_sensor(@key)
	# 	expect(sensor.is_a?(Datonis::Sensor)).to  eq true
	# end

	# it "create" do
	# 	stub_request(:post, %r|/sensors|).to_return(body: load_v2_fixture(:sensor))
	# 	sensor = @datonis.create_sensor({sensor: @new_attrs})
	# 	expect(sensor.is_a?(Datonis::Sensor)).to  eq true
	# 	puts sensor
	# 	puts sensor.sensor_key
	# end

	# it "update" do
	# 	stub_request(:get, %r|/sensors/#{@key}|).to_return(body: load_v2_fixture(:sensor))
	# 	sensor = @datonis.get_sensor(@key)
	# 	stub_request(:put, %r|/sensors/#{sensor.sensor_key}|).to_return(body: load_v2_fixture(:sensor))
	# 	sensor.name = 'updatename'
	# 	expect(@datonis.save(sensor)).to eq true
	# 	expect(sensor.valid?).to eq true
	# end

	# it "update fail" do
	# 	stub_request(:get, %r|/sensors/#{@key}|).to_return(body: load_v2_fixture(:sensor))
	# 	sensor = @datonis.get_sensor(@key)
	# 	stub_request(:put, %r|/sensors/#{sensor.sensor_key}|).to_return(body: load_v2_fixture(:sensor_error))
	# 	sensor.name = 'updatename'
	# 	expect(@datonis.save(sensor)).to eq false
	# 	expect(sensor.errors.size>0).to eq true
	# end

	# it "last event time" do
	# 	stub_request(:get, %r|/sensors/#{@key}|).to_return(body: load_v2_fixture(:sensor))
	# 	sensor = @datonis.get_sensor(@key)
	# 	stub_request(:get, %r|/sensors/#{@key}/sensor_last_event_time|).to_return(body: load_v2_fixture(:sensor_last_event_time))
	# 	ts = @datonis.sensor_last_event_time(sensor)
	# 	expect(ts.is_a? Integer).to  eq true
	# end

	# it "status" do
	# 	keys = ['4fa2t52f2ecffec234b5137c23681165852ft99b', 'c1e5f3268caceccd845656c11d52422t9t773d51']
	# 	stub_request(:get, %r|/sensors/sensors_status|).to_return(body: load_v2_fixture(:sensors_status))
	# 	status = @datonis.sensors_status({sensors: keys})
	# 	expect(status.is_a? Hash).to  eq true
	# end

	# it "sensors_last_event_time" do
	# 	keys = ['4fa2t52f2ecffec234b5137c23681165852ft99b', 'c1e5f3268caceccd845656c11d52422t9t773d51']
	# 	stub_request(:get, %r|/sensors/sensors_last_event_time|).to_return(body: load_v2_fixture(:sensors_last_event_time))
	# 	status = @datonis.sensors_last_event_time({sensors: keys})
	# 	expect(status.is_a? Hash).to  eq true
	# end

	

	# it "destroy" do
	# 	stub_request(:get, %r|/sensors/#{@key}|).to_return(body: load_v2_fixture(:sensor))
	# 	sensor = @datonis.get_sensor(@key)
	# 	stub_request(:delete, %r|/sensors/#{@key}|).to_return(body:  "{\"success\":true}")
	# 	expect(@datonis.destroy(sensor)).to  eq true
	# end

end