require "bundler/setup"

Bundler.require(:default)

class String

  def encrypt(key = "Some random key")
    blowfish = Kruptos::Blowfish.new(key)
    
    String val = self

    # pad the value to be 8 bytes aligned.
    (8-(val.length % 8)).times { val += "\012" }
    encodedString = Base64.encode64(val)
    
    encryptedValue = ""
    (
      chunk = val.slice!(0,8)
      encryptedValue += blowfish.encrypt_block(chunk)
    ) until val.empty?
    
    return ::Base64.encode64(encryptedValue);
  end

  def decrypt(key = "Some random key")
    blowfish = Kruptos::Blowfish.new(key)
    value = ::Base64.decode64(self)
    
    decryptedValue = ""
    (
      chunk = value.slice!(0,8)
      decryptedValue += blowfish.decrypt_block(chunk)
    ) until value.empty?
    
    (
      decryptedValue = decryptedValue.chomp("\012")
    ) until (decryptedValue[decryptedValue.length-1] != "\012")

    return decryptedValue
  end

end

# String foo = "This is cool".encrypt("blablabla")
# puts foo => "WuwcAFdNWrtdn4SANiTxgg=="
# puts foo.decrypt("blablabla") => "This is cool"
# puts foo.decrypt("blablabla").length => 12

# String foo = "This is cool".encrypt
# puts foo
# puts foo.decrypt
# puts foo.decrypt.length

