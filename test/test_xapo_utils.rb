require 'minitest/autorun'
require 'xapo_utils'

class TestXapoUtils < Minitest::Test
  def setup     
  end

  def test_encrypt()
    json = '{"sender_user_id":"s160901",' +
            '"sender_user_email":"fernando.taboada@gmail.com",' +
            '"sender_user_cellphone":"",' +
            '"receiver_user_id":"r160901",' +
            '"receiver_user_email":"fernando.taboada@xapo.com",' +
            '"tip_object_id":"to160901",' +
            '"amount_SAT":"",' +
            '"timestamp":1410973639125}'
    expected = 'rjiFHpE3794U23dEKNyEz3ukF5rhVxtKzxEnZq8opuHoRH5eA' +
            '/XOEbROEzf5AYmyQ5Yw6cQLSVMx/JgENrNKVK268n3o1kOIxEpupaha2wYX' +
            'LqIqU8Ye7LFQz7NvQNPzfyOSPWnBQ/JUCSKsCiCz45VoK511B/RMz33mjJM' +
            'F7s2a6FEk6YOwf3hrvYwFt1frXLDwxsAwMXKUutIdfnrM2c6MYOFXTSGqZc' +
            '2gS8DXmwHyIrXKUFCt7Ax3DMk0ao7iAE8MiXWaSSSZRVBQ7d1a9JDRoNtzq' +
            'GB++p7zK4NmOdrGEX9f+EwBjYuyKSsNez7kXPAWzwEvoi1o8gu4bxA1ng=='

    actual = XapoUtils.encrypt(json, "bc4e142dc053407b0028accffc289c18").tr("\n","")
    
    assert_equal(expected, actual)
  end
end