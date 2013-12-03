require "gitit"

module Gitit
    
  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class Repo
    attr_reader :location;
  
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def initialize(location)
      raise "Invalid path specified" unless File.directory? location
      @location = location
    end
  
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def valid?
      commandres = `(cd #{@location} && git rev-parse --git-dir >/dev/null 2>&1)`
      return true unless $?.exitstatus != 0 
      return false
    end
  
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def init
      raise "already a git repo" if valid?
      commandres = `(cd #{@location} && git init)`
    end
  end
    
end
