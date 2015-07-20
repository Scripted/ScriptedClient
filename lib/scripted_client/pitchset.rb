module ScriptedClient
  class Pitchset < Resource
    define_filter_methods(%w(open closed requires_action))
    has_many :pitches, class_name: 'scripted_client/pitch'
  end
end
