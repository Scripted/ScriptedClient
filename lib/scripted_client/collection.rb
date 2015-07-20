module ScriptedClient
  class Collection < ActiveResource::Collection

    attr_accessor :next_page

    def initialize(parsed = {})
      @elements = parsed['data']
      paging = parsed['paging']
      @next_page = paging['next_cursor'] if paging['has_next']
    end

    def next
      fail 'No more pages' unless has_next?
      resource_class.all(
        params: original_params.merge(next_cursor: next_page)
      )
    end

    def has_next?
      next_page.present?
    end

  end
end
