require 'test_helper'

class FirstDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get first_dashboard_index_url
    assert_response :success
  end

end
