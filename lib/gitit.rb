require "bundler/setup"
require "gitit/version"

Bundler.require(:default)

module Gitit
  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class GitIt 
    attr_reader :repoLocation;
  
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def initialize(repoLocation)
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
    def readConfiguration(configData)
      configData.instance_variables.each do |v|
        globalEntry = configData.instance_variable_get(v)
        
        globalEntry.instance_variables.each do |sv|
          begin
            entry = globalEntry.instance_variable_get(sv)
            entry.value = getConfigValue("scm-workflow.#{globalEntry.class.name.split('::').last.downcase}.#{sv[1..-1]}", entry.hideinput)
          rescue => exception
            return false
          end
        end
      end

      return true
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def getConfigValue(key, decrypt = false)
      value = `git config --null --get "#{key}"`
      if (decrypt && $?.exitstatus == 0)
        blowfish = Crypt::Blowfish.new("this is a long key aaaaa")
        value = Base64.decode64(value)

        decryptedValue = ""
        (
          chunk = value.slice!(0,8)
          decryptedValue += blowfish.decrypt_block(chunk)
        ) until value.empty?

        (
          decryptedValue = decryptedValue.chomp("\012")
        ) until (decryptedValue[decryptedValue.length-1] != "\012")
        
        value = decryptedValue
      end
      
      puts key.rjust(50) + " : " + value
      return value unless $?.exitstatus != 0
      raise "missing key"
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def setConfigValue(key, value, encrypt = false)
    
      val = value
      if (encrypt && !value.empty?)
      
        begin
          blowfish = Crypt::Blowfish.new("this is a long key aaaaa")
          
          # pad the value to be 8 bytes aligned.
          (8-(val.length % 8)).times { val += "\012" }
          encodedString = Base64.encode64(val)
          
          encryptedValue = ""
          (
            chunk = val.slice!(0,8)
            encryptedValue += blowfish.encrypt_block(chunk)
          ) until val.empty?

          val = Base64.encode64(encryptedValue);
        rescue => ex
          puts "error"
          puts ex.to_s
        end
      end
    
      puts "Storing : " + val + " : " + key
      `git config "#{key}" "#{val}"`
      puts $?.exitstatus
      raise "failed to set the key" if $?.exitstatus != 0
    end

  end

end

