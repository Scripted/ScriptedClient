module ScriptedClient
  class Resource < ActiveResource::Base
    self.format = :json
    self.collection_parser = ScriptedClient::Collection

    # Some tasteful meta-programming to define
    # filter methods, for example:
    ### ScriptedClient::Job.needs_review
    def self.define_filter_methods(filters)
      filters.each do |filter|
        define_singleton_method(filter) do
          all(params: { filter: filter })
        end
      end
    end

    def self.site
      super if ScriptedClient.organization_key && ScriptedClient.access_token
    end

    # A hook for any nested resources
    # (see ScriptedClient::Pitch for implementation)
    def self.setup_prefix; end

  end
end
