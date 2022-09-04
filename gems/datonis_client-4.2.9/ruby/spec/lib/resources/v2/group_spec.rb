require 'spec_helper'
describe "group" do

	before(:each) do
		@key = 'afa2t5'
		login('test@altizon.com', 'test123')
	end

	it "list" do
		stub_request(:get, %r|/groups|).to_return(body: load_v2_fixture(:groups))
		groups = @datonis.all_groups
		expect(groups.count).to  eq 2
	end

	it "show" do
		stub_request(:get, %r|/groups/#{@key}|).to_return(body: load_v2_fixture(:group))
		group = @datonis.get_group({id:@key, fetch_sensor_key: 1})
		expect(group.is_a?(Datonis::Group)).to  eq true
		puts group.sensors.count
		puts group.sensors.last.inspect
	end

end
