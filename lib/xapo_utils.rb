require "openssl"
require "base64"

module XapoUtils

  module_function
          
  # Do PKCS#7 padding and encrypting.
  #
  # Args:
  #   payload (str): The text to encode.
  #   secret (str): the encoding key.
  #   default_padding (bool): whether it uses default padding or not 
  #   
  # Returns:
  #  str: The padded bytestring.
  def encrypt(payload, secret, default_padding=true)
    cipher = OpenSSL::Cipher::AES.new("256-ECB")
    cipher.encrypt
    cipher.key = secret

    # TODO zero padding is not handled correctly, it's too specific
    #      and inflexible making it hard to change.
    if !default_padding
      cipher.padding = 0
      payload = zero_padding(payload)
    end        

    encrypted = cipher.update(payload) + cipher.final

    return Base64.encode64(encrypted)
  end

  def timestamp; (Time.now.to_f * 1000).to_i end

  def zero_padding(payload)
    l = 16 - payload.length % 16
    res = payload + "\0" * l

    return res 
  end
end