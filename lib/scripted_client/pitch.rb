module ScriptedClient
  class Pitch < Resource
    def self.find(*arguments)
      if arguments.first.kind_of?(String)
        options = arguments[1]
        unless options.kind_of?(Hash) &&
          options[:params].kind_of?(Hash) &&
          options[:params].key?(:pitchset_id)
          fail "You must pass both a pitchset_id and an id to #{ name }#find. For example: \n
            #{ name }.find('#{ arguments.first }', params: { pitchset_id: 'abc123' }) \n\n\n"
        end
      end
      super
    end

    def self.setup_prefix
      self.prefix = "#{ prefix }pitchsets/:pitchset_id/"
    end

    def accept(feedback = nil)
      set_pitchset_prefix
      post(:accept, {}, { feedback: feedback }.to_json)
    end

    def reject(feedback = nil)
      set_pitchset_prefix
      post(:reject, {}, { feedback: feedback }.to_json)
    end

    private

    def set_pitchset_prefix
      self.prefix_options[:pitchset_id] = pitchset.id
    end
  end
end
