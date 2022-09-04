module ApiHelper

	def load_fixture(resource)
		File.read(File.dirname(__FILE__) + "/fixtures/#{resource.to_s}.json")
	end

	def load_v2_fixture(resource)
		File.read(File.dirname(__FILE__) + "/fixtures/v2/#{resource.to_s}.json")
	end

	def login(email, password)
		stub_request(:post,  "http://api.datonis.io/api_sign_in").to_return(:body=> load_fixture(:api_sign_in))
		@datonis = Datonis::Api.new(email, password)
		expect(@datonis.valid?).to  eq true
		expect(@datonis.user.email==email).to  eq true
		expect(@datonis.user.is_a?(Datonis::User)).to  eq true
	end

	def login_v2(email, password)
		stub_request(:post,  "http://datonis.altizon.com/api_sign_in").to_return(:body=> load_fixture(:api_sign_in))
		@datonis = Datonis::Api.new(email, password, 'v2')
		expect(@datonis.valid?).to  eq true
		expect(@datonis.user.email==email).to  eq true
		expect(@datonis.user.is_a?(Datonis::User)).to  eq true
	end
end