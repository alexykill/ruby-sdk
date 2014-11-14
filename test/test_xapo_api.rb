require "minitest/autorun"
require "xapo_api"
require "securerandom"

class TestXapoAPI < Minitest::Test
  def setup     
    @api = Xapo::API.new(
      "http://dev.xapo.com/api/v1", 
      "your app id", 
      "your app secret"
    )
  end

  def test_credit()
    # TODO: remove skip
    skip("Set app id and secret and remove this line")

    res = @api.credit('sample@xapo.com', 1, SecureRandom.hex, 
                      currency: Xapo::Currency::SAT,
                      comments: "Sample deposit")

    puts("test_credit -> ", res)

    assert(res["success"])
  end

  def test_credit_bad_ammount()
    # TODO: remove skip
    skip("Set app id and secret and remove this line")

    res = @api.credit('sample@xapo.com', -0.5, SecureRandom.hex)

    puts("test_credit -> ", res)

    refute(res["success"])
    assert_equal("InvalidAmount", res["code"])
  end

  def test_credit_missing_to()
    # TODO: remove skip
    skip("Set app id and secret and remove this line")

    res = @api.credit('', -0.5, SecureRandom.hex)

    puts("test_credit -> ", res)

    refute(res["success"])
    assert_equal("Failure", res["code"])
  end
end