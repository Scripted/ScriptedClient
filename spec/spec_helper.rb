require 'bundler'
Bundler.setup

require 'rspec'
require 'scripted_client'

RSpec.configure do |config|
  config.before(:all) do
    ScriptedClient.env = :dev
    ScriptedClient.id = '4a7da4c3'
    ScriptedClient.access_token = '5soiSLVM3Yh-mwRUKbKT'
  end
end
