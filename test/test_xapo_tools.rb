require "minitest/autorun"
require "xapo_tools"

class TestXapoTools < Minitest::Test
  def setup     
    @xapo_tools = XapoTools::MicroPayment.new(
      "https://mpayment.xapo.com/pay_button/show",  
      "your app id", 
      "your app secret"
    )
    @xapo_tools_notpa = XapoTools::MicroPayment.new(
      "https://mpayment.xapo.com/pay_button/show"
    )
  end

  def test_build_iframe_widget()
    # TODO: remove skip
    skip("Set app id and secret and remove this line")

    config = XapoTools.micro_payment_config
    config[:sender_user_email] = "sender@xapo.com"
    config[:sender_user_cellphone] = "+5491112341234"
    config[:receiver_user_id] = "r0210"
    config[:receiver_user_email] = "fernando.taboada@xapo.com"
    config[:pay_object_id] = "to0210"
    config[:amount_BIT] = 0.01
    config[:pay_type] = PayType::DONATE
    config[:reference_code] = "test"
    config[:end_mpayment_uri] = "http://localhost:9000"
    config[:redirect_uri] = "http://localhost:9000"

    customization = XapoTools.micro_payment_customization
    customization[:predefined_pay_values] = "1,5,10"
    customization[:login_cellphone_header_title] = "Test MicroPayment"
    customization[:button_css] = "grey"

    actual = @xapo_tools.build_iframe_widget(config, customization)
    puts("test_build_iframe_widget -> ", actual)

    assert_match(/<iframe(.*)button_request(.*)>(.*)<\/iframe>\n/m, actual)
  end

  def test_build_iframe_widget_notpa()
    # TODO: remove skip
    skip("Set app id and secret and remove this line")

    config = XapoTools.micro_payment_config
    config[:sender_user_email] = "sender@xapo.com"
    config[:sender_user_cellphone] = "+5491112341234"
    config[:receiver_user_id] = "r0210"
    config[:receiver_user_email] = "fernando.taboada@xapo.com"
    config[:pay_object_id] = "to0210"
    config[:amount_BIT] = 0.01
    config[:pay_type] = PayType::DONATE
    config[:reference_code] = "test"
    config[:end_mpayment_uri] = "http://localhost:9000"
    config[:redirect_uri] = "http://localhost:9000"

    customization = XapoTools.micro_payment_customization
    customization[:predefined_pay_values] = "1,5,10"
    customization[:login_cellphone_header_title] = "Test MicroPayment"
    customization[:button_css] = "red"

    actual = @xapo_tools_notpa.build_iframe_widget(config, customization)
    puts("test_build_iframe_widget_notpa -> ", actual)

    assert_match(/<iframe(.*)payload(.*)>(.*)<\/iframe>\n/m, actual)
  end

  def test_build_div_widget()
    # TODO: remove skip
    skip("Set app id and secret and remove this line")

    config = XapoTools.micro_payment_config
    config[:sender_user_email] = "sender@xapo.com"
    config[:sender_user_cellphone] = "+5491112341234"
    config[:receiver_user_id] = "r0210"
    config[:receiver_user_email] = "fernando.taboada@xapo.com"
    config[:pay_object_id] = "to0210"
    config[:amount_BIT] = 0.01
    config[:pay_type] = PayType::TIP
    config[:reference_code] = "test"
    config[:end_mpayment_uri] = "http://localhost:9000"
    config[:redirect_uri] = "http://localhost:9000"

    customization = XapoTools.micro_payment_customization
    customization[:predefined_pay_values] = "1,5,10"
    customization[:login_cellphone_header_title] = "Test MicroPayment"
    customization[:button_css] = "red"

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
    # TODO: remove skip
    skip("Set app id and secret and remove this line")

    config = XapoTools.micro_payment_config
    config[:sender_user_email] = "sender@xapo.com"
    config[:sender_user_cellphone] = "+5491112341234"
    config[:receiver_user_id] = "r0210"
    config[:receiver_user_email] = "fernando.taboada@xapo.com"
    config[:pay_object_id] = "to0210"
    config[:amount_BIT] = 0.01
    config[:pay_type] = PayType::TIP
    config[:reference_code] = "test"
    config[:end_mpayment_uri] = "http://localhost:9000"
    config[:redirect_uri] = "http://localhost:9000"

    customization = XapoTools.micro_payment_customization
    customization[:predefined_pay_values] = "1,5,10"
    customization[:login_cellphone_header_title] = "Test MicroPayment"
    customization[:button_css] = "grey"

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