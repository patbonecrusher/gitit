require "gitit/command_executor"

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
    def getValue(key)
      value = executeCommand("config --null --get #{key}")
      raise "failure running command" if $?.exitstatus != 0
      value = value.slice!(0, value.length-1)
      return value
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def setValue(key, value)
      val = value
      executeCommand("config \"#{key}\" \"#{val}\"")
      raise "failure running command" if $?.exitstatus != 0
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def getGlobalValue(key)
      value = executeCommand("config --global --null --get #{key}")
      raise "failure running command" if $?.exitstatus != 0
      value = value.slice!(0, value.length-1)
      return value
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def setGlobalValue(key, value)
      val = value
      executeCommand("config --global \"#{key}\" \"#{val}\"")
      raise "failure running command" if $?.exitstatus != 0
    end
    
  end


end
