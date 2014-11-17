require "xapo_sdk/version"
require "xapo_utils"

require "json"
require "uri"
require "net/http"

module Xapo

  module_function

  module Currency
    BTC = "BTC"
    SAT = "SAT"
  end
  
  # Xapo's API.
  #
  # This class allows the interaction with bitcoins APIs provided with Xapo.
  #
  # Params:
  #    +service_url+ (str): The endpoint URL that returns the payment widget.
  #    +app_id+ (str): The id of the TPA doing the credit.
  #    +app_secret+ (str): The TPA secret used to encrypt payload.
  class API    
    def initialize(service_url, app_id, app_secret)
      @service_url = service_url
      @app_id = app_id
      @app_secret = app_secret
      @credit_resource = '/credit/'
    end

    # Transfer a given amount from the main wallet of the TPA to a given sub account.
    #
    # Params:
    #     +to+ (str): the destination of the credit.
    #     +amount+ (decimal): the amount to be credited.
    #     +requestId+ (str): a unique identifier for the credit operation.
    #     +currency+ (Xapo::Currency): the currency of the operation (SAT|BTC).
    def credit(to, amount, request_id, currency: Xapo::Currency::BTC, 
               comments: "", subject: "")
      timestamp = XapoUtils.timestamp
      payload = {
                  :to => to,
                  :currency => currency,
                  :amount => amount,
                  :comments => comments,
                  :subject => subject,
                  :timestamp => timestamp,
                  :unique_request_id => request_id
                }
      
      json_payload = JSON.generate(payload)
      encrypted_payload = XapoUtils.encrypt(json_payload, @app_secret, false)
      
      uri = URI(@service_url + @credit_resource)
      query = URI.encode_www_form(:appID => @app_id,
                                  :hash => encrypted_payload)
      uri.query = query
      res = Net::HTTP.get_response(uri)

      return JSON.parse(res.body)
    end
  end
end
