# require 'spec_helper'

# describe "Device" do
# 	before(:each) do
# 		@key = 'afa2t52f2ecffec234b5137c23681165852ft99b'
# 		@new_attrs = {name: 'test device 1', description: 'testdevice'}
# 		login('test@altizon.com', 'test123')
# 	end

# 	it "list" do
# 		stub_request(:get, %r|/devices|).to_return(body: load_fixture(:devices))
# 		devices = @datonis.all_devices
# 		expect(devices.count).to  eq 3
# 	end

# 	it "show" do
# 		stub_request(:get, %r|/devices/#{@key}|).to_return(body: load_fixture(:device))
# 		device = @datonis.get_device(@key)
# 		expect(device.is_a?(Datonis::Device)).to  eq true
# 	end

# 	it "create" do
# 		stub_request(:post, %r|/devices|).to_return(body: load_fixture(:device))
# 		device = @datonis.create_device({device: @new_attrs})
# 		expect(device.is_a?(Datonis::Device)).to  eq true
# 	end

# 	it "update" do
# 		stub_request(:get, %r|/devices/#{@key}|).to_return(body: load_fixture(:device))
# 		device = @datonis.get_device(@key)
# 		stub_request(:put, %r|/devices/#{device.device_key}|).to_return(body: load_fixture(:device))
# 		device.name = 'updatename'
# 		expect(@datonis.save(device)).to eq true
# 		expect(device.valid?).to eq true
# 	end

	
# 	it "status" do
# 		keys = ['4fa2t52f2ecffec234b5137c23681165852ft99b', 'c1e5f3268caceccd845656c11d52422t9t773d51']
# 		stub_request(:get, %r|/devices/devices_status|).to_return(body: load_fixture(:devices_status))
# 		status = @datonis.devices_status({devices: keys})
# 		expect(status.is_a? Hash).to  eq true
# 	end

# 	it "tag" do
# 		tags = 'a,b'
# 		stub_request(:get, %r|/devices/#{@key}|).to_return(body: load_fixture(:device))
# 		device = @datonis.get_device(@key)
# 		stub_request(:put, %r|/devices/#{@key}/tag|).to_return(body: load_fixture(:device))
# 		expect(@datonis.tag(device, {tags: tags})==true).to eq true
# 	end

# 	it "untag" do
# 		tags = 'a,b'
# 		stub_request(:get, %r|/devices/#{@key}|).to_return(body: load_fixture(:device))
# 		device = @datonis.get_device(@key)
# 		stub_request(:put, %r|/devices/#{@key}/untag|).to_return(body: load_fixture(:device))
# 		expect(@datonis.untag(device, {tags: tags})==true).to eq true
# 	end

# 	it "destroy" do
# 		stub_request(:get, %r|/devices/#{@key}|).to_return(body: load_fixture(:device))
# 		device = @datonis.get_device(@key)
# 		stub_request(:delete, %r|/devices/#{@key}|).to_return(body:  "{\"success\":true}")
# 		expect(@datonis.destroy(device)).to  eq true
# 	end

# 	it "search" do
# 		search = 'test'
# 		stub_request(:get, %r|/devices/search|).to_return(:body=> load_fixture(:device_search))
# 		params = {search: search}
# 		results = @datonis.devices_search(params)
# 		expect(results.search_results_count).to  eq 1
# 		expect(results.search_results.size> 0).to  eq true
# 		expect(results.search_results.first.is_a? Datonis::Device).to  eq true
# 	end
# end