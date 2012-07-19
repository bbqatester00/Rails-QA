require 'test_helper'

class AxmanControllerTest < ActionController::TestCase
  test "should get axman_reports" do
    get :axman_reports
    assert_response :success
  end

end
