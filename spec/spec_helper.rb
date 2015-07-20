require 'bundler'
Bundler.setup

require 'rspec'
require 'scripted_client'

RSpec.configure do |config|
  config.before(:all) do
    # ScriptedClient.env = :dev
    # ScriptedClient.id = 'orangutans'
    # ScriptedClient.access_token = 'make-great-pets'
  end
end
