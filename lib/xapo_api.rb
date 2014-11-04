require "xapo_sdk/version"
require "xapo_utils"

require "json"
require "uri"
require "net/http"

# Xapo's API.
#
# This class allows the interaction with bitcoins APIs provided with Xapo.
#
# Attributes:
#    service_url (str): The endpoint URL that returns the payment widget.
#    app_id (str, optional): The id of the TPA for which the widget will be created.
#    app_secret (str, optional): The TPA secret used to encrypt widget configuration.
module Xapo

  module_function

  module Currency
    BTC = "BTC"
    SAT = "SAT"
  end
  
  class API    
    def initialize(service_url, app_id, app_secret)
      @service_url = service_url
      @app_id = app_id
      @app_secret = app_secret
      @credit_resource = '/credit/'
    end

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
