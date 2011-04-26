require 'test_helper'

class SchoolsControllerTest < ActionController::TestCase  
  
  def setup
    # @user = users(:cpfb)
    # @user.confirm!
    # sign_in :user, @user
  end
  
  
  
  
  test "should get index when user is signed in" do
    login
    get :index
    assert_response :success
  end
  
  test "should redirect to sign_in page when trying to access index if user is not signed in" do
    get :index
    redirected_to_sign_in?
  end
  
  test "should get new when user is signed in" do
    login
    get :new
    assert_response :success
  end
  
  test "should redirect to sign_in page when trying to access new if user is not logged in" do
    get :new
    redirected_to_sign_in?
  end
    
  test "should have one more school after creating school" do
    login
    assert_difference('School.count') do
      post :create, :school => { :school_name => "River Crest Middle School" }
    end
    assert_redirected_to root_path
    assert_equal flash[:notice], "School saved successfully."
  end
  
  test "should get show page when user is signed in" do
    login
    get :show, :id => schools(:rhhs).id
    assert_response :success
  end
  
  test "should redirect to sign_in page when trying to access show page if user is not logged in" do
    get :show, :id => schools(:rhhs).id
    redirected_to_sign_in?
  end
  
  test "should get edit page when user is signed in" do
    login
    get :edit, :id => schools(:rhhs).id
    assert_response :success
  end
  
  test "should redirect to sign_in page when trying to access edit page if user is not logged in" do
    get :edit, :id => schools(:rhhs).id
    redirected_to_sign_in?
  end
  
  # test "school should have different name after editing school_name" do
  #   login
  #   school_name = schools(:rhhs).school_name
  #   post :update, :id => schools(:rhhs).id, :school => { :school_name => "Heath HS" }
  #   assert_equal flash[:notice], "School was updated successfully."
  #   assert_not_equal school_name, schools(:rhhs).school_name
  # end
  
end
