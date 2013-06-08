require "bundler/setup"
require "gitit/command_executor"

Bundler.require(:default)

module Gitit

  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class Config
    include CommandExecutor
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def initialize(repo)
      @repo = repo
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def getValue(key, decrypt = false)
      value = executeCommand("config --null --get #{key}")
      value = value.slice!(0, value.length-1)
      return value
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def setValue(key, value)
      val = value
      executeCommand("config \"#{key}\" \"#{val}\"")
    end
    
  end


end