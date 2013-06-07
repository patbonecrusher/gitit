require "bundler/setup"
require "gitit"

Bundler.require(:default)

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
      commandres = `(cd #{@location} && git status 2&>/dev/null)`
      return true unless $?.exitstatus != 0 
      return false
    end
  
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def init
      raise "failed to create repo" if valid?
      commandres = `(cd #{@location} && git init)`
    end
  end
    
end
