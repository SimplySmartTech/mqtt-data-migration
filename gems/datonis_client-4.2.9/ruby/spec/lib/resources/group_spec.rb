require 'spec_helper'
describe "group" do

	before(:each) do
		@key = 'afa2t5'
		login('test@altizon.com', 'test123')
	end

	it "list" do
		stub_request(:get, %r|/groups|).to_return(body: load_fixture(:groups))
		groups = @datonis.all_groups
		expect(groups.count).to  eq 2
	end

	it "show" do
		stub_request(:get, %r|/groups/#{@key}|).to_return(body: load_fixture(:group))
		group = @datonis.get_group(@key)
		expect(group.is_a?(Datonis::Group)).to  eq true
		puts group.sensors.count
		puts group.sensors.last.inspect
	end

	it "create" do
		stub_request(:post, %r|/groups|).to_return(body: load_fixture(:group))
		group = @datonis.create_group({group: @new_attrs})
		expect(group.is_a?(Datonis::Group)).to  eq true
	end

	it "update" do
		stub_request(:get, %r|/groups/#{@key}|).to_return(body: load_fixture(:group))
		group = @datonis.get_group(@key)
		stub_request(:put, %r|/groups/#{group.group_key}|).to_return(body: load_fixture(:group))
		group.name = 'updatename'
		expect(@datonis.save(group)).to eq true
		expect(group.valid?).to eq true
	end

	it "destroy" do
		stub_request(:get, %r|/groups/#{@key}|).to_return(body: load_fixture(:group))
		group = @datonis.get_group(@key)
		stub_request(:delete, %r|/groups/#{@key}|).to_return(body:  "{\"success\":true}")
		expect(@datonis.destroy(group)).to  eq true
	end

end
