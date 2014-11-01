# README

>This is the Ruby version of the Xapo's Widget Tools. These tools allow you (Third Party Application, TPA) to easily embed tools like Payments Buttons, Donation Buttons and other kind of widgets as DIV or iFrame into your web application using your language of choice. In this way, tedious details like encryption and HTML snippet generation are handled for you in a simple and transparent way.  

---

[Changelog](CHANGELOG.md)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Table of Contents 

- [Table of Contents](#table-of-contents)
  - [Build](#build)
  - [Installation](#installation)
  - [Micro Payment Widgets](#micro-payment-widgets)
    - [IFrame Widget](#iframe-widget)
    - [Div Widget](#div-widget)
    - [Widgets Gallery](#widgets-gallery)
  - [Contributing](#contributing)
  - [TODO](#todo)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Build

Ensure that tests pass:

    $ rake test 

Build the gem (output to `./pkg`):

    $ rake build

And finally install de gem:

    $ rake install

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xapo_sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xapo_sdk

## Micro Payment Widgets
Micro payment widgets allow to dynamically get a HTML snippet pre-configured and insert into your web page. Micro payment widgets provides 4 kind of pre-configured actions __Pay, Donate, Tip__ and __Deposit__. The widgets allow the following configurations:

- **Amount BIT:** `[optional]` sets a fixed amount for the intended payment.
- **Sender's Id:** `[optional]` any identifier used in the TPA context to identify the sender.
- **Sender's email:** `[optional]` used to pre-load the widget with the user's email.
- **Sender's cellphone:** `[optional]` used to pre-load the widget with the user's cellphone.
- **Receiver's Id:** `[mandatory]` any receiver's user unique identifier in the TPA context. 
- **Receiver's email:** `[mandatory]` the email of the user receiving the payment. It allows XAPO to contact the receiver to claim her payment.
- **Pay Object's Id:** `[mandatory]` any unique identifier in the context of the TPA distinguishing the object of the payment.
- **Pay type:** `[optional]` any of Donate | Pay | Tip | Deposit.

Be aware that micro payments could be optionally configured with your own application id and secret (`app_id`/`app_secret`). Configuring the micro payment with your application credentials allows you to charge a transaction fee for example.

### IFrame Widget
```ruby
require 'xapo_tools'

...

micro_payment = XapoTools::MicroPayment.new(
                                            XAPO_URL, 
                                            APP_ID,    # optional
                                            APP_SECRET # optional
                                           )
config = XapoTools.micro_payment_config

config[:sender_user_email] = "sender@xapo.com"
config[:sender_user_cellphone] = "+5491112341234"
config[:receiver_user_id] = "r0210"
config[:receiver_user_email] = "fernando.taboada@xapo.com"
config[:pay_object_id] = "to0210"
config[:amount_BIT] = 0.01
config[:pay_type] = PayType::DONATE

# Get IFRAME snippet
String iframe = microPayment.buildIframeWidget(request);
```

With this you get the following snippet:

```html
<iframe id='tipButtonFrame' scrolling='no' frameborder='0' style='border:none; overflow:hidden; height:22px;' allowTransparency='true' src='http://dev.xapo.com:8089/pay_button/show?customization=%7B%22button_text%22%3A%22Tip%22%7D&app_id=b91014cc28c94841&button_request=C%2F6OaxS0rh3jMhH90kRYyp3y%2BU5ADcCgMLCyz2P5ssFG%2FJoGf55ccvicyRMuIXpU5xhDeHGffpZAvVeMCpJhGFyIPwLFh%2FVdnjnDUjYgJCQeB4mCpGsEW5SC6wNvg69ksgeAtr108Wc5miA8H4JG99EWTTlC7WtIGg5rFKkbjrop15fSJfhv5cTs02jSC5f2BaLlh1mKh5hSPW3HGcWcl%2BdyZj%2F9m1lPB4gKfky2%2FnT0tYjbEFo5aU6WtowWrf2xE8OYejyI0poEFkClBkv2eDkp4Gel4tGb%2Bkwszcyb18ztK89RlBwhe8sX4HeM2KJM8ZaWuDOGH2VW4kbThMCZEw%3D%3D'></iframe>
```

See the example results in the [widgets gallery](#widgets-gallery).

### Div Widget
```ruby
require 'xapo_tools'

...

micro_payment = XapoTools::MicroPayment.new(
                                            XAPO_URL, 
                                            APP_ID,     # optional 
                                            APP_SECRET  # optional
                                           )
config = XapoTools.micro_payment_config

config[:sender_user_email] = "sender@xapo.com"
config[:sender_user_cellphone] = "+5491112341234"
config[:receiver_user_id] = "r0210"
config[:receiver_user_email] = "fernando.taboada@xapo.com"
config[:pay_object_id] = "to0210"
config[:amount_BIT] = 0.01
config[:pay_type] = PayType::TIP

# PayType::TIP | PayType::PAY | PayType::DEPOSIT | PayType::DONATE
config[:pay_type] = PayType::DONATE

# Get DIV snippet
xapo_tools.build_div_widget(config)
```

With this you get the following snippet:

```html
<div id='tipButtonDiv' class='tipButtonDiv'></div>
<div id='tipButtonPopup' class='tipButtonPopup'></div>
<script>
$(document).ready(function() {$('#tipButtonDiv').load('http://dev.xapo.com:8089/pay_button/show?customization=%7B%22button_text%22%3A%22Donate%22%7D&app_id=b91014cc28c94841&button_request=C%2F6OaxS0rh3jMhH90kRYyp3y%2BU5ADcCgMLCyz2P5ssFG%2FJoGf55ccvicyRMuIXpU5xhDeHGffpZAvVeMCpJhGFyIPwLFh%2FVdnjnDUjYgJCQeB4mCpGsEW5SC6wNvg69ksgeAtr108Wc5miA8H4JG99EWTTlC7WtIGg5rFKkbjrop15fSJfhv5cTs02jSC5f2BaLlh1mKh5hSPW3HGcWcl%2BdyZj%2F9m1lPB4gKfky2%2FnT0tYjbEFo5aU6WtowWrf2xE8OYejyI0poEFkClBkv2eDkp4Gel4tGb%2Bkwszcyb18ztK89RlBwhe8sX4HeM2KJMHVfAM8NQXQu8oiIyCAl0vg%3D%3D');});
</script>
```

See the example results in the [widgets gallery](#widgets-gallery).

### Widgets Gallery

![payment button](http://developers.xapo.com/images/payment_widget/donate_button.png)

![payment phone](http://developers.xapo.com/images/payment_widget/mpayment1.png)

![payment email](http://developers.xapo.com/images/payment_widget/mpayment2.png)

![payment pin](http://developers.xapo.com/images/payment_widget/mpayment3.png)

## Contributing

1. Fork it ( https://github.com/xapo/ruby-sdk/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## TODO
- ~~Fix style (https://github.com/bbatsov/ruby-style-guide#naming)~~
- ~~Add unit testing~~
- Document, document, ~~document~~
- ~~Review naming and organization (with respect to Java & Python?)~~
- ~~Review `gem` build infraestructure~~
- ...
