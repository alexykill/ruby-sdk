require "openssl"
require "base64"

module XapoUtils

    module_function
            
    def encrypt(payload, secret)
        cipher = OpenSSL::Cipher::AES.new("256-ECB")
        cipher.encrypt
        cipher.key = secret        

        encrypted = cipher.update(payload) + cipher.final

        return Base64.encode64(encrypted)
    end

    def timestamp; (Time.now.to_f * 1000).to_i end
end