require "minitest/autorun"
require "xapo_tools"

class TestXapoTools < Minitest::Test
    def setup     
        @xapo_tools = XapoTools::MicroPayment.new(
            "http://dev.xapo.com:8089/pay_button/show", 
            "b91014cc28c94841", 
            "c533a6e606fb62ccb13e8baf8a95cbdc")
        @xapo_tools_notpa = XapoTools::MicroPayment.new(
            "http://dev.xapo.com:8089/pay_button/show")
    end

    def test_build_iframe_widget()
        config = XapoTools.micro_payment_config
        config[:sender_user_email] = "sender@xapo.com"
        config[:sender_user_cellphone] = "+5491112341234"
        config[:receiver_user_id] = "r0210"
        config[:receiver_user_email] = "fernando.taboada@xapo.com"
        config[:pay_object_id] = "to0210"
        config[:amount_BIT] = 0.01
        config[:pay_type] = PayType::DONATE

        actual = @xapo_tools.build_iframe_widget(config)

        assert_match(/<iframe(.*)request_button(.*)>(.*)<\/iframe>\n/m, actual)
    end

    def test_build_iframe_widget_notpa()
        config = XapoTools.micro_payment_config
        config[:sender_user_email] = "sender@xapo.com"
        config[:sender_user_cellphone] = "+5491112341234"
        config[:receiver_user_id] = "r0210"
        config[:receiver_user_email] = "fernando.taboada@xapo.com"
        config[:pay_object_id] = "to0210"
        config[:amount_BIT] = 0.01
        config[:pay_type] = PayType::DONATE

        actual = @xapo_tools_notpa.build_iframe_widget(config)

        assert_match(/<iframe(.*)payload(.*)>(.*)<\/iframe>\n/m, actual)
    end

    def test_build_div_widget()
        config = XapoTools.micro_payment_config
        config[:sender_user_email] = "sender@xapo.com"
        config[:sender_user_cellphone] = "+5491112341234"
        config[:receiver_user_id] = "r0210"
        config[:receiver_user_email] = "fernando.taboada@xapo.com"
        config[:pay_object_id] = "to0210"
        config[:amount_BIT] = 0.01
        config[:pay_type] = PayType::TIP
        regex = /
                    <div\sid="tipButtonDiv"\sclass="tipButtonDiv"><\/div>\n
                    <div\sid="tipButtonPopup"\sclass="tipButtonPopup"><\/div>\n
                    <script>(.*)request_button(.*)<\/script>\n
                /mx

        actual = @xapo_tools.build_div_widget(config)

        assert_match(regex, actual)
    end

    def test_build_div_widget_notpa()
        config = XapoTools.micro_payment_config
        config[:sender_user_email] = "sender@xapo.com"
        config[:sender_user_cellphone] = "+5491112341234"
        config[:receiver_user_id] = "r0210"
        config[:receiver_user_email] = "fernando.taboada@xapo.com"
        config[:pay_object_id] = "to0210"
        config[:amount_BIT] = 0.01
        config[:pay_type] = PayType::TIP
        regex = /
                    <div\sid="tipButtonDiv"\sclass="tipButtonDiv"><\/div>\n
                    <div\sid="tipButtonPopup"\sclass="tipButtonPopup"><\/div>\n
                    <script>(.*)payload(.*)<\/script>\n
                /mx

        actual = @xapo_tools_notpa.build_div_widget(config)

        assert_match(regex, actual)
    end
end