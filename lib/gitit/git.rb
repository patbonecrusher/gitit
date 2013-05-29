require "bundler/setup"
require "gitit"
require "gitit/command_config"

Bundler.require(:default)

module Gitit
  
  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class Git 
    attr_reader :repoLocation;
    attr_reader :config;
  
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def initialize(repoLocation)
      @config = Config.new(nil)
      @config.repoLocation = repoLocation
      @repoLocation = repoLocation
      raise "Invalid path specified" unless File.directory? @repoLocation
    end
  
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def isAValidRepo?
      commandres = `(cd #{@repoLocation} && git status 2&>/dev/null)`
      return true unless $?.exitstatus != 0 
      return false
    end
  
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def createNewRepo()
      raise "failed to create repo" if isAValidRepo?
      commandres = `(cd #{@repoLocation} && git init)`
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def saveConfiguration(configData, prefix)
      configData.instance_variables.each do |sv|
        begin
          entry = configData.instance_variable_get(sv)
          classname = configData.class.name.split('::').last.downcase
          valuename = sv[1..-1]
          setConfigValue("#{prefix}.#{classname}.#{valuename}", entry.value, entry.hideinput)
        rescue => exception
          return false
        end
      end

      return true
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def readConfiguration(configData, prefix)
      configData.instance_variables.each do |sv|
        begin
          entry = configData.instance_variable_get(sv)
          classname = configData.class.name.split('::').last.downcase
          valuename = sv[1..-1]
          entry.value = getConfigValue("#{prefix}.#{classname}.#{valuename}", entry.hideinput)
        rescue => exception
          return false
        end
      end

      return true
    end

  end

end

  
