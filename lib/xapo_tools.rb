require "xapo_sdk/version"
require "xapo_utils"

require "json"
require "uri"
require 'yaml'

module XapoTools

    module_function 

    def micro_payment_config
        return Hash[:sender_user_id => '', :sender_user_email => '', 
                    :sender_user_cellphone => '', :receiver_user_id => '', 
                    :receiver_user_email => '', :pay_object_id => '', 
                    :amount_BIT => 0, :timestamp => XapoUtils.timestamp]
    end

    class MicroPayment
        def initialize(service_url, app_id, app_secret)
            @service_url = service_url
            @app_id = app_id
            @app_secret = app_secret
        end

        def build_url(config, pay_type)
            json_config = JSON.generate(config)
            encrypted_config = XapoUtils.encrypt(json_config, @app_secret)

            query_str = URI.encode_www_form(
                "app_id" => @app_id, 
                "button_request" => encrypted_config,
                "customization" => JSON.generate({"button_text" => pay_type}))

            widget_url = @service_url + "?" + query_str

            return widget_url
        end

        def build_iframe_widget(config, pay_type)
            widget_url = build_url(config, pay_type)

            snippet = YAML::load(<<-END)
            |

                <iframe id="tipButtonFrame" scrolling="no" frameborder="0"
                    style="border:none; overflow:hidden; height:22px;"
                    allowTransparency="true" src="#{widget_url}">
                </iframe>
            END

            return snippet
        end

        def build_div_widget(config, pay_type)
            widget_url = build_url(config, pay_type)

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
end