require 'test_helper'

class PaymentControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get payment_show_url
    assert_response :success
  end

  test "should get new" do
    get payment_new_url
    assert_response :success
  end

end
