require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index when logged in" do
    login
    get :index
    assert_response :success
  end
  
  test "should get index when not logged in" do
    get :index
    assert_response :success
  end

end
