module ScriptedClient
  API_VERSION = 'v1'
  @@access_token, @@id = nil, nil
  @@env = :sandbox

  def self.access_token
    @@access_token || fail("You must set #{ name }.access_token")
  end

  def self.access_token=(_access_token)
    @@access_token = _access_token
    reset_resource_site
    @@access_token
  end

  def self.id
    @@id || fail("You must set #{ name }.id")
  end

  def self.id=(_id)
    @@id = _id
    reset_resource_site
    @@id
  end

  def self.env
    @@env
  end

  def self.env=(_env)
    unless [:dev, :sandbox, :production].include?(_env)
      fail "#{ name }.env must be either :sandbox or :production"
    end
    @@env = _env
    reset_resource_site
    @@env
  end

  def self.base_host
    case env
    when :sandbox
      'scripted-sandbox.herokuapp.com'
    when :production
      'api.scripted.com'
    when :dev
      'localhost:3000'
    end
  end

  def self.protocol
    env == :dev ? 'http' : 'https'
  end

  def self.base_url
    "#{ protocol }://#{ base_host }"
  end

  def self.prefix
    "/#{ id }/#{ API_VERSION }/"
  end

  def self.reset_resource_site
    if @@id && @@access_token
      ScriptedClient::Resource.site = base_url
      ScriptedClient::Resource.prefix = prefix
      ScriptedClient::Resource.headers['Authorization'] = "Token token=#{ access_token }"
    end
  end
end

require 'active_resource'
require 'scripted_client/collection'
require 'scripted_client/resource'
require 'scripted_client/job'
require 'scripted_client/job_template'
require 'scripted_client/industry'
require 'scripted_client/pitch'
require 'scripted_client/pitchset'
