require "gitit/command_executor"

module Gitit

  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class Config
    include CommandExecutor
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def initialize(repo, location='')
      @repo = repo
      @location = location
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def getValue(key)
      value = executeCommand("config #{@location} --null --get #{key}")
      raise "failure running command" if $?.exitstatus != 0
      value = value.slice!(0, value.length-1)
      return value
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def setValue(key, value)
      val = value
      executeCommand("config #{@location} \"#{key}\" \"#{val}\"")
      raise "failure running command" if $?.exitstatus != 0
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def unsetValue(key)
      value = executeCommand("config #{@location} --null --unset #{key}")
      raise "failure running command" if $?.exitstatus != 0
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def removeSection(section)
      executeCommand("config #{@location} --remove-section #{section}")
      raise "failure running command" if $?.exitstatus != 0
    end
    
  end

  class LocalConfig
  end

  class GlobalConfig
  end

end
