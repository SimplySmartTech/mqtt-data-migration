require 'spec_helper'

describe "User" do
	before(:each) do
		@key = 'testkey'
		login('test@altizon.com', 'test123')
	end

	it "list" do
		stub_request(:get, %r|/users|).to_return(body: load_fixture(:users))
		users = @datonis.all_users
		expect(users.count).to  eq 2
	end

	it "show" do
		stub_request(:get, %r|/users/#{@key}|).to_return(body: load_fixture(:user))
		user = @datonis.get_user(@key)
		expect(user.is_a?(Datonis::User)).to  eq true
	end


	it "update" do
		stub_request(:get, %r|/users/#{@key}|).to_return(body: load_fixture(:user))
		user = @datonis.get_user(@key)
		stub_request(:put, %r|/users/#{user.key}|).to_return(body: load_fixture(:user))
		user.first_name = 'foo'
		user.last_name = 'bar'
		expect(@datonis.save(user)).to eq true
		expect(user.valid?).to eq true
	end

	

end