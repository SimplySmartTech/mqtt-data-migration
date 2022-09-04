require 'datonis_client'
require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end
require 'webmock/rspec'
require 'api_helper'


WebMock.disable_net_connect!
#See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true

  config.include ApiHelper
end