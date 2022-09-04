# require 'spec_helper'

# describe "Gateway" do
# 	before(:each) do
# 		@key = 'afa2t52f2ecffec234b5137c23681165852ft99b'
# 		@new_attrs = {name: 'test gateway 1', description: 'testgateway'}
# 		login('test@altizon.com', 'test123')
# 	end

# 	it "list" do
# 		stub_request(:get, %r|/gateways|).to_return(body: load_fixture(:gateways))
# 		gateways = @datonis.all_gateways
# 		expect(gateways.count).to  eq 3
# 	end

# 	it "show" do
# 		stub_request(:get, %r|/gateways/#{@key}|).to_return(body: load_fixture(:gateway))
# 		gateway = @datonis.get_gateway(@key)
# 		expect(gateway.is_a?(Datonis::Gateway)).to  eq true
# 	end

# 	it "create" do
# 		stub_request(:post, %r|/gateways|).to_return(body: load_fixture(:gateway))
# 		gateway = @datonis.create_gateway({gateway: @new_attrs})
# 		expect(gateway.is_a?(Datonis::Gateway)).to  eq true
# 	end

# 	it "update" do
# 		stub_request(:get, %r|/gateways/#{@key}|).to_return(body: load_fixture(:gateway))
# 		gateway = @datonis.get_gateway(@key)
# 		stub_request(:put, %r|/gateways/#{gateway.gateway_key}|).to_return(body: load_fixture(:gateway))
# 		gateway.name = 'updatename'
# 		expect(@datonis.save(gateway)).to eq true
# 		expect(gateway.valid?).to eq true
# 	end

	
# 	it "status" do
# 		keys = ['4fa2t52f2ecffec234b5137c23681165852ft99b', 'c1e5f3268caceccd845656c11d52422t9t773d51']
# 		stub_request(:get, %r|/gateways/gateways_status|).to_return(body: load_fixture(:gateways_status))
# 		status = @datonis.gateways_status({gateways: keys})
# 		expect(status.is_a? Hash).to  eq true
# 	end

# 	it "tag" do
# 		tags = 'a,b'
# 		stub_request(:get, %r|/gateways/#{@key}|).to_return(body: load_fixture(:gateway))
# 		gateway = @datonis.get_gateway(@key)
# 		stub_request(:put, %r|/gateways/#{@key}/tag|).to_return(body: load_fixture(:gateway))
# 		expect(@datonis.tag(gateway, {tags: tags})==true).to eq true
# 	end

# 	it "untag" do
# 		tags = 'a,b'
# 		stub_request(:get, %r|/gateways/#{@key}|).to_return(body: load_fixture(:gateway))
# 		gateway = @datonis.get_gateway(@key)
# 		stub_request(:put, %r|/gateways/#{@key}/untag|).to_return(body: load_fixture(:gateway))
# 		expect(@datonis.untag(gateway, {tags: tags})==true).to eq true
# 	end

# 	it "destroy" do
# 		stub_request(:get, %r|/gateways/#{@key}|).to_return(body: load_fixture(:gateway))
# 		gateway = @datonis.get_gateway(@key)
# 		stub_request(:delete, %r|/gateways/#{@key}|).to_return(body:  "{\"success\":true}")
# 		expect(@datonis.destroy(gateway)).to  eq true
# 	end

# 	it "search" do
# 		search = 'test'
# 		stub_request(:get, %r|/gateways/search|).to_return(:body=> load_fixture(:gateway_search))
# 		params = {search: search}
# 		results = @datonis.gateways_search(params)
# 		expect(results.search_results_count).to  eq 1
# 		expect(results.search_results.size> 0).to  eq true
# 		expect(results.search_results.first.is_a? Datonis::Gateway).to  eq true
# 	end
# end