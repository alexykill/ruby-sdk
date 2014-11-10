# README

>This is the Ruby version of the Xapo's SDK & Widget Tools. These tools allow you (Third Party Application, TPA) to easily develop your bitcoins applications to manage *Accounts, Wallets, Transactions*, etc., or embed tools like *Payments Buttons, Donation Buttons* and other kind of widgets into your web application using your language of choice. In this way, tedious details like encryption and HTML snippet generation are handled for you in a simple and transparent way.

For more information please visit: http://developers.xapo.com

---

[![Gem Version](https://badge.fury.io/rb/xapo_sdk.svg)](http://badge.fury.io/rb/xapo_sdk)
[![Build Status](https://travis-ci.org/xapo/ruby-sdk.svg?branch=master)](https://travis-ci.org/xapo/ruby-sdk)

[Changelog](CHANGELOG.md)

## Table of Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Build](#build)
- [Installation](#installation)
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


## Contributing

1. Fork it ( https://github.com/xapo/ruby-sdk/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## TODO
- ~~Fix style (https://github.com/bbatsov/ruby-style-guide#naming)~~
- ~~Add unit testing~~
- Document, ~~document~~, ~~document~~
- ~~Review naming and organization (with respect to Java & Python?)~~
- ~~Review `gem` build infraestructure~~
- ...
