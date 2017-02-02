require 'test_helper'

class OtpRegistrationControllerTest < ActionDispatch::IntegrationTest
  test "should get new," do
    get otp_registration_new,_url
    assert_response :success
  end

  test "should get create," do
    get otp_registration_create,_url
    assert_response :success
  end

  test "should get update" do
    get otp_registration_update_url
    assert_response :success
  end

end
