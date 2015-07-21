module ScriptedClient
  class Industry < Resource

    # Caching because industries never change
    def self.all(*args)
      @@all ||= super
    end

  end
end
