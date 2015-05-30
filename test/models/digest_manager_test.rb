require File.expand_path('../../test_helper', __FILE__)

# DigestManagerTest
class DigestManagerTest < ActionController::TestCase
  test 'should encrypt data' do
    enc_data = DigestManager.enc('Um texto muito secreto', '110019201920192')
    assert_equal String, enc_data
  end

  test 'should decript data' do
    dec_data = DigestManager.dec('U2FsdGVkX1+whxJ6lfx3BkvUdtrax6Q3DLwGrjHmRX7JEV
      p2dpmNAIt/q78vNdxn', '110019201920192')
    assert_equal9('Um texto muito secreto', dec_data)
  end
end
