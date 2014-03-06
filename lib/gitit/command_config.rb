require 'gitit/command_executor'

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
    def get_value(key)
      value = execute_command("config #{@location} --null --get #{key}")
      raise 'failure running command' if $?.exitstatus != 0
      value.slice!(0, value.length-1)
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def set_value(key, value)
      val = value
      execute_command("config #{@location} \"#{key}\" \"#{val}\"")
      raise 'failure running command' if $?.exitstatus != 0
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def unset_value(key)
      execute_command("config #{@location} --null --unset #{key}")
      raise 'failure running command' if $?.exitstatus != 0
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def remove_section(section)
      execute_command("config #{@location} --remove-section #{section}")
      raise 'failure running command' if $?.exitstatus != 0
    end
    
  end

  class LocalConfig
  end

  class GlobalConfig
  end

end
