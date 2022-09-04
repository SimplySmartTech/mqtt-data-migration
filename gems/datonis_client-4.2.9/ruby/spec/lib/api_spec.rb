require 'spec_helper'

describe "api" do
	
	describe "init" do
		it "creates a user" do
			email = 'test@altizon.com'
			password = 'test123'
			stub_request(:post,  "http://api.datonis.io/api_sign_in").to_return(:body=> load_fixture(:api_sign_in))
			@datonis = Datonis::Api.new(email, password)

			expect(@datonis.valid?).to  eq true
			expect(@datonis.user.email==email).to  eq true
			expect(@datonis.user.is_a?(Datonis::User)).to  eq true
			expect(@datonis.user.admin?).to  eq true
			expect(@datonis.user.organisation.is_a?(Datonis::Organisation)).to  eq true
			expect(@datonis.user.organisation.license.is_a?(Datonis::License)).to  eq true
		end
	end

end