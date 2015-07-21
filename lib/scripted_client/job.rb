module ScriptedClient
  class Job < Resource
    define_filter_methods(%w(
      screening
      writing
      draft_ready
      revising
      final_ready
      in_progress
      needs_review
      accepted
      rejected
      finished))

    def html_contents
      get(:html_contents)['html_contents']
    end

  end
end
