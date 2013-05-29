require "bundler/setup"

Bundler.require(:default)

module Gitit

  # -------------------------------------------------------------------------
  # -------------------------------------------------------------------------
  class ConfigElement
    attr_reader :info;
    attr_accessor :value;
    attr_reader :hideinput;
    
    def initialize (info, hideinput, default)
      @info = info;
      @hideinput = hideinput;
      @value = default;
    end
  end
  
  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class Config
    
    attr_accessor :repoLocation;
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def initialize(executor)
      @executor = executor
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def getValue(key, decrypt = false)
      value = `(cd #{@repoLocation} && git config --null --get "#{key}")`
      value = value.slice!(0, value.length-1)
      if (decrypt && $?.exitstatus == 0)
        blowfish = Kruptos::Blowfish.new("this is a long key aaaaa")
        value = ::Base64.decode64(value)
        
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
      
      return value unless $?.exitstatus != 0
      raise "missing key"
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def setValue(key, value, encrypt = false)
      
      val = value
      if (encrypt && !value.empty?)
        
        begin
          blowfish = Kruptos::Blowfish.new("this is a long key aaaaa")
          
          # pad the value to be 8 bytes aligned.
          (8-(val.length % 8)).times { val += "\012" }
          encodedString = Base64.encode64(val)
          
          encryptedValue = ""
          (
           chunk = val.slice!(0,8)
           encryptedValue += blowfish.encrypt_block(chunk)
           ) until val.empty?
          
          val = ::Base64.encode64(encryptedValue);
          rescue => ex
          puts "error"
          puts ex.to_s
        end
      end
      
      `(cd #{@repoLocation} && git config "#{key}" "#{val}")`
      raise "failed to set the key" if $?.exitstatus != 0
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def saveConfigObject(configData, prefix)
      configData.instance_variables.each do |sv|
        begin
          entry = configData.instance_variable_get(sv)
          classname = configData.class.name.split('::').last.downcase
          valuename = sv[1..-1]
          setValue("#{prefix}.#{classname}.#{valuename}", entry.value, entry.hideinput)
        rescue => exception
          return false
        end
      end
      
      return true
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def readConfigObject(configData, prefix)
      configData.instance_variables.each do |sv|
        begin
          entry = configData.instance_variable_get(sv)
          classname = configData.class.name.split('::').last.downcase
          valuename = sv[1..-1]
          entry.value = getValue("#{prefix}.#{classname}.#{valuename}", entry.hideinput)
        rescue => exception
          return false
        end
      end
      
      return true
    end
    
  end


end
