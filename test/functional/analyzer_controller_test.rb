require 'test_helper'

class AnalyzerControllerTest < ActionController::TestCase
  test "should get analyzer" do
    get :analyzer
    assert_response :success
  end

end
