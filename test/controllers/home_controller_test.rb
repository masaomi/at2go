require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get get_annotation" do
    get home_get_annotation_url
    assert_response :success
  end

end
