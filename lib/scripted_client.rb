module ScriptedClient
  API_VERSION = 'v1'
  @@access_token, @@organization_key = nil, nil
  @@env = :sandbox

  def self.access_token
    @@access_token || fail("You must set #{ name }.access_token")
  end

  def self.access_token=(_access_token)
    @@access_token = _access_token
    reset_resource_site
    @@access_token
  end

  def self.organization_key
    @@organization_key || fail("You must set #{ name }.organization_key")
  end

  def self.organization_key=(_organization_key)
    @@organization_key = _organization_key
    reset_resource_site
    @@organization_key
  end

  def self.env
    @@env
  end

  def self.env=(_env)
    unless [:development, :sandbox, :production].include?(_env)
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
    when :development
      'localhost:3000'
    end
  end

  def self.protocol
    env == :development ? 'http' : 'https'
  end

  def self.base_url
    "#{ protocol }://#{ base_host }"
  end

  def self.prefix
    "/#{ organization_key }/#{ API_VERSION }/"
  end

  def self.reset_resource_site
    if @@organization_key && @@access_token
      ScriptedClient::Resource.site = base_url
      ScriptedClient::Resource.prefix = prefix
      ScriptedClient::Resource.descendants.each(&:setup_prefix)
      ScriptedClient::Resource.headers['Authorization'] = "Bearer #{ access_token }"
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
