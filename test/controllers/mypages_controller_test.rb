require "test_helper"

class MypagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get mypages_home_url
    assert_response :success
  end

  test "should get contact" do
    get mypages_contact_url
    assert_response :success
  end

  test "should get about_us" do
    get mypages_about_us_url
    assert_response :success
  end

  test "should get product" do
    get mypages_product_url
    assert_response :success
  end
end
