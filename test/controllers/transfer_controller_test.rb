require 'test_helper'

class TransferControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get transfer_show_url
    assert_response :success
  end

  test "should get new" do
    get transfer_new_url
    assert_response :success
  end

end
