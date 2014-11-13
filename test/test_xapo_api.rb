require "minitest/autorun"
require "xapo_api"
require "securerandom"

# TODO: removed test since it's is not testable without a VPN o a valid IP 
# making Travis CI test to fail.
class TestXapoAPI # < Minitest::Test
  def setup     
    @api = Xapo::API.new(
      "http://dev.xapo.com/api/v1", 
      "b91014cc28c94841", 
      "c533a6e606fb62ccb13e8baf8a95cbdc"
    )
  end

  def test_credit()
    res = @api.credit('sample@xapo.com', 1, SecureRandom.hex, 
                      currency: Xapo::Currency::SAT,
                      comments: "Sample deposit")

    puts("test_credit -> ", res)

    assert(res["success"])
  end

  def test_credit_bad_ammount()
    res = @api.credit('sample@xapo.com', -0.5, SecureRandom.hex)

    puts("test_credit -> ", res)

    refute(res["success"])
    assert_equal("InvalidAmount", res["code"])
  end

  def test_credit_missing_to()
    res = @api.credit('', -0.5, SecureRandom.hex)

    puts("test_credit -> ", res)

    refute(res["success"])
    assert_equal("Failure", res["code"])
  end
end