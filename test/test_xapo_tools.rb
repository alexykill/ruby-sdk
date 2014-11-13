require "minitest/autorun"
require "xapo_tools"

class TestXapoTools < Minitest::Test
  def setup     
    @xapo_tools = XapoTools::MicroPayment.new(
      "http://dev.xapo.com:8089/pay_button/show", 
      "b91014cc28c94841", 
      "c533a6e606fb62ccb13e8baf8a95cbdc"
    )
    @xapo_tools_notpa = XapoTools::MicroPayment.new(
      "http://dev.xapo.com:8089/pay_button/show"
    )
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
    config[:reference_code] = "test"

    customization = XapoTools.micro_payment_customization
    customization[:predefined_pay_values] = "1,5,10"
    customization[:end_mpayment_uri] = "http://localhost:9000"
    customization[:redirect_uri] = "http://localhost:9000"
    customization[:button_css] = "grey"

    actual = @xapo_tools.build_iframe_widget(config, customization)
    puts("test_build_iframe_widget -> ", actual)

    assert_match(/<iframe(.*)button_request(.*)>(.*)<\/iframe>\n/m, actual)
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
    config[:reference_code] = "test"

    customization = XapoTools.micro_payment_customization
    customization[:predefined_pay_values] = "1,5,10"
    customization[:end_mpayment_uri] = "http://localhost:9000"
    customization[:redirect_uri] = "http://localhost:9000"
    customization[:button_css] = "red"

    actual = @xapo_tools_notpa.build_iframe_widget(config, customization)
    puts("test_build_iframe_widget_notpa -> ", actual)

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
    config[:reference_code] = "test"

    customization = XapoTools.micro_payment_customization
    customization[:predefined_pay_values] = "1,5,10"
    customization[:end_mpayment_uri] = "http://localhost:9000"
    customization[:redirect_uri] = "http://localhost:9000"
    customization[:button_css] = "grey"

    regex = /
                <div\sid="tipButtonDiv"\sclass="tipButtonDiv"><\/div>\n
                <div\sid="tipButtonPopup"\sclass="tipButtonPopup"><\/div>\n
                <script>(.*)button_request(.*)<\/script>\n
            /mx

    actual = @xapo_tools.build_div_widget(config, customization)
    puts("test_build_div_widget -> ", actual)

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
    config[:reference_code] = "test"

    customization = XapoTools.micro_payment_customization
    customization[:predefined_pay_values] = "1,5,10"
    customization[:end_mpayment_uri] = "http://localhost:9000"
    customization[:redirect_uri] = "http://localhost:9000"
    customization[:button_css] = "red"

    regex = /
                <div\sid="tipButtonDiv"\sclass="tipButtonDiv"><\/div>\n
                <div\sid="tipButtonPopup"\sclass="tipButtonPopup"><\/div>\n
                <script>(.*)payload(.*)<\/script>\n
            /mx

    actual = @xapo_tools_notpa.build_div_widget(config, customization)
    puts("test_build_div_widget_notpa -> ", actual)

    assert_match(regex, actual)
  end
end