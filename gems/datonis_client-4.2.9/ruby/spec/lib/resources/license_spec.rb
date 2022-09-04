require 'spec_helper'

describe "License" do
	before(:each) do
		login('test@altizon.com', 'test123')
	end

	it "plan" do
		stub_request(:get, %r|licenses/plan|).to_return(:body=>load_fixture(:license_plan))
		license_plan = @datonis.license_plan
		expect(license_plan.name=='Advanced').to  eq true
	end

	it "keys" do
		stub_request(:get, %r|licenses/keys|).to_return(:body=>load_fixture(:license_keys))
		keys = @datonis.license_keys
		expect(keys.access_key=='82ae47799c717242ft7babba81dt3bd7ttcb63c1').to  eq true
		expect(keys.secret_key=='99a83226b6t1a3f69b13f179b319e8224c7td45a').to  eq true
	end
end