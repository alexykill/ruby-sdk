require "xapo_sdk/version"
require "xapo_utils"

require "json"
require "uri"
require "yaml"

module XapoTools

  module_function 

  # Micro payment button configuration options.
  #
  # This function is intended to be a helper for creating empty micro
  # payments buttons configuration but also serves for documenting. A 
  # hash with the intended fields would give the same results.
  #
  # Params:
  #   +sender_user_id+ (str): The id of the user sending the payment.
  #   +sender_user_email+ (str, optional): The email of the user sending
  #     the payment.
  #   +sender_user_cellphone+ (str, optional): The celphone number of the user
  #     sending the payment.
  #   +receiver_user_id+ (str): The id of the user receiving the payment.
  #   +receiver_user_email+ (str): The email of the user receiving the payment.
  #   +pay_object_id+ (str): A payment identifier in the TPA context.
  #   +amount_BIT+ (float, optional): The amount of bitcoins to be payed by the
  #     widget. If not specified here, it must be entered on payment basis.
  #   +pay_type+ (str): The string representing the type of operation
  #     ("Tip", "Pay", "Deposit" or "Donate").
  #   +reference_code+ (str, optional): A custom code to be tracked by the TPA. It's 
  #     sent back to the TPA in the specified callback. It could be used also to search 
  #     with the micro payments query API.
  #   +end_mpayment_uri+ (str, optional): The callback URL to notify a successful 
  #     micro payment. The callback will be called with parameters 
  #     "reference_code" and "request_UID".
  #   +end_mpayment_redirect_uri+ (str, optional): An URL to be redirected to after
  #     a successful micro payment.
  #   +redirect_uri+ (str, optional): redirect URL after a successful OAuth flow.
  #     The URL must accept a "code" parameter if access is granted or
  #     "error" and "error_description" in case of denial.
  def micro_payment_config
    return Hash[
                :sender_user_id => "", 
                :sender_user_email => "", 
                :sender_user_cellphone => "", 
                :receiver_user_id => "", 
                :receiver_user_email => "", 
                :pay_object_id => "", 
                :amount_BIT => 0, 
                :timestamp => XapoUtils.timestamp, 
                :pay_type => "",
                :reference_code => "",
                :end_mpayment_uri => "",
                :end_mpayment_redirect_uri => "",
                :redirect_uri => ""
              ]
  end


  # Micro payment button customization options.
  #
  # This function is intended to be a helper for creating empty micro
  # payments buttons customization but also serves for documenting. A 
  # hash with the intended fields would give the same results.
  # 
  # Params:
  #   +login_cellphone_header_title+ (str, optional): Text to appear in the login 
  #     screen. Default: "Support content creators by sending them bits. 
  #     New users receive 50 bits to get started!"
  #   +predefined_pay_values+ (str, optional): A string of comma separated
  #     amount values, e.g. "1,5,10".
  #   +button_css+ (str, optional): optional CSS button customization ("red" | "grey").
  def micro_payment_customization
    return Hash[
                :login_cellphone_header_title => "",
                :predefined_pay_values => "", 
                :button_css => "" 
              ]
  end

  # Xapo's payment buttons snippet builder.
  #
  # This class allows the construction of 2 kind of widgets, *div* and
  # *iframe*. The result is a HTML snippet that could be embedded in a
  # web page for doing micro payments though a payment button.
  #
  # Params:
  #   +service_url+ (str): The endpoint URL that returns the payment widget.
  #   +app_id+ (str, optional): The id of the TPA for which the widget will be created.
  #   +app_secret+ (str, optional): The TPA secret used to encrypt widget configuration.
  class MicroPayment    
    def initialize(service_url, app_id=nil, app_secret=nil)
      @service_url = service_url
      @app_id = app_id
      @app_secret = app_secret
    end

    def build_url(config, customization)
      json_config = JSON.generate(config)
      
      if @app_secret == nil || @app_id == nil
        query_str = URI.encode_www_form(
          :payload => json_config,
          :customization => JSON.generate(customization)
        )
      else
        encrypted_config = XapoUtils.encrypt(json_config, @app_secret)

        query_str = URI.encode_www_form(
          :app_id => @app_id, 
          :button_request => encrypted_config,
          :customization => JSON.generate(customization)
        )
      end

      widget_url = @service_url + "?" + query_str

      return widget_url
    end

    # Build an iframe HTML snippet in order to be embedded in apps.
    #
    # Params:
    #   +config+ (+Hash+): The button configuration options.
    #   See @micro_payment_config.
    #
    # Returns:
    #   string: the iframe HTML snippet ot be embedded in a page.
    def build_iframe_widget(config, customization=XapoTools::micro_payment_customization)
      widget_url = build_url(config, customization)

      snippet = YAML::load(<<-END)
      |
          <iframe id="tipButtonFrame" scrolling="no" frameborder="0"
              style="border:none; overflow:hidden; height:22px;"
              allowTransparency="true" src="#{widget_url}">
          </iframe>
      END

      return snippet
    end

    # Build div HTML snippet in order to be embedded in apps.
    #
    # Params:
    #   +config+ (+Hash+): The button configuration options.
    #   See @micro_payment_config.
    #
    # Returns:
    #   string: the div HTML snippet ot be embedded in a page.
    def build_div_widget(config, customization=XapoTools::micro_payment_customization)
      widget_url = build_url(config, customization)

      snippet = YAML::load(<<-END)
      |
          <div id="tipButtonDiv" class="tipButtonDiv"></div>
          <div id="tipButtonPopup" class="tipButtonPopup"></div>
          <script>
              $(document).ready(function() {{
                  $("#tipButtonDiv").load("#{widget_url}");
              }});
          </script>
      END

      return snippet
    end

    private :build_url
  end
end

module PayType
  TIP = "Tip"
  DONATE = "Donate"
  PAY = "Pay"
  DEPOSIT = "Deposit"
  OAUTH = "Oauth"
end