require 'test_helper'

class LessonsControllerTest < ActionController::TestCase
  
  def setup
    @lesson_hash = {
      :student_id => students(:demura).id,
      :instructor_id => users(:cpfb).instructor.id,
      :datetime => Time.now,
      :charge => 15.00,
      :notes => "Great sound!"
    }
  end
  
  
  test "get index lesson page if logged in" do
    login
    get :index
    assert_response :success
  end
  
  test "redirect to sign in page if not logged in when trying to access index" do
    get :index
    redirected_to_sign_in?
  end
  
  test "get new page if logged in" do
    login
    get :new
    assert_response :success
  end
  
  test "redirect to sign in page if not logged in when trying to access new" do
    get :new
    redirected_to_sign_in?
  end
  
  test "create lesson if logged in" do
    login
    assert_difference('Lesson.count') do
      post :create, :lesson => @lesson_hash
    end
  end
  
  test "show lesson that belongs to logged in user" do
    login
    get :show, :id => lessons(:one).id
    assert_response :success
  end
  
  test "show lesson if logged in user is an admin" do
    login(:admin)
    get :show, :id => lessons(:one).id
    assert_response :success
  end
  
  test "redirect to home page when accessing show if lesson does not belong to logged in user" do
    login(:loser)
    get :show, :id => lessons(:one).id
    assert_redirected_to root_path
  end
  
  test "edit lesson if logged in and lesson belongs to user" do
    login
    get :edit, :id => lessons(:one).id
    assert_response :success
  end
  
  test "edit lesson if logged in and user is an admin" do
    login(:admin)
    get :edit, :id => lessons(:one).id
    assert_response :success
  end
  
  test "redirect to root path if logged in when trying to access edit for lesson that user does not own" do
    login(:loser)
    get :edit, :id => lessons(:one).id
    assert_redirected_to root_path
  end
  
  test "redirect to sign in page if not logged in when trying to access edit" do
    get :edit, :id => lessons(:one).id
    redirected_to_sign_in?
  end
  
  # test "update lesson if logged in and lesson belongs to user" do
  #   login
  #   @lesson_hash[:charge] = 150.00
  #   post :update, :id => lessons(:one).id, :lesson => @lesson_hash
  #   assert_not_equal 15, lessons(:one).charge
  # end
  
  test "delete lesson that belongs to logged in user" do
    login
    assert_difference('Lesson.count', -1) do
      delete :destroy, :id => lessons(:one).id
    end
  end
  
  test "delete lesson when logged in user is an admin" do
    login(:admin)
    assert_difference('Lesson.count', -1) do
      delete :destroy, :id => lessons(:one).id
    end
  end
  
  test "redirect to root page if try to delete lesson that user does not own" do
    login(:loser)
    delete :destroy, :id => lessons(:one).id
    assert_redirected_to root_path
  end
  
  
end
