require 'test_helper'

class StudentsControllerTest < ActionController::TestCase

  def setup
    @student_hash = {
      :first_name => "Johnny",
      :last_name => "Fuller",
      :school_id => "Poteet High School",
      :instructor_id => users(:cpfb).instructor.id,
      :email => "jafuller@hotmail.org"
    }
  end
  
  test "should get index if logged in" do
    login
    get :index
    assert_response :success
  end
  
  test "should be redirected to login page if index is accessed while logged out" do
    get :index
    redirected_to_sign_in?
  end
  
  test "should get new if logged in" do
    login
    get :new
    assert_response :success
  end
  
  test "should be redirected to login page if new is accessed while logged out" do
    get :new
    redirected_to_sign_in?
  end
  
  test "should create new school if new school name is put in school_name field" do
    login
    @student_hash[:school_id] = "Park Cities School"
    assert_difference('School.count') do
      post :create, :student => @student_hash
    end
  end
  
  test "should use appropriate school instance if not a new school name is put in the school_name field" do
    login
    @student_hash[:school_id] = "Rockwall Heath High School"
    post :create, :student => @student_hash
    johnny = Student.find_by_email("jafuller@hotmail.org")
    assert_equal johnny.school, schools(:rhhs)
  end
  
  test "should have one more student after creating new student" do
    login
    assert_difference('Student.count') do
      post :create, :student => @student_hash
    end
    assert_equal flash[:notice], "Student was saved successfully."
  end
  
  test "should get the show page if the user is signed in and the signed in user owns the student" do
    login
    get :show, :id => students(:demura).id
    assert_response :success
  end
  
  test "should get the show page if the user is signed in and the signed in user is an admin" do
    login(:admin)
    get :show, :id => students(:demura).id
    assert_response :success
  end
  
  test "should get redirect to the home page if the user is signed in but does not own the student" do
    login(:loser)
    get :show, :id => students(:demura).id
    assert_redirected_to root_path
  end
  
  test "should redirect to signin page if try to access show while not signed in" do
    get :show, :id => students(:demura).id
    redirected_to_sign_in?
  end
  
  test "should get the edit page if the user is signed in and user owns the student" do
    login
    get :edit, :id => students(:demura).id
    assert_response :success
  end
  
  # test "should get the edit page if the user is signed in and user is an admin" do
  #   login(:admin)
  #   get :edit, :id => students(:demura).id
  #   assert_response :success
  # end
  
  test "should redirect to the home page if the user is signed in but does not own the student" do
    login(:loser)
    get :edit, :id => students(:demura).id
    assert_redirected_to root_path
  end
  
  test "should redirect to signin page if try to access edit while not signed in" do
    get :edit, :id => students(:demura).id
    redirected_to_sign_in?
  end
  
  # test "student should have different first_name after updating with different first name" do
  #   login
  #   @student_hash[:school_id] = schools(:phs).id
  #   johnny = Student.create!(@student_hash)
  #   @student_hash[:first_name] = "Heather"
  #   post :update, :id => johnny.id, :student => @student_hash
  #   assert_not_equal johnny.first_name, "Johnny"
  # end

  test "should delete student if logged in and user owns the student" do
    login
    assert_difference('Student.count', -1) do
      delete :destroy, :id => students(:demura).id
    end
  end

  test "should delete student if logged in and user is an admin" do
    login(:admin)
    assert_difference('Student.count', -1) do
      delete :destroy, :id => students(:demura).id
    end
  end

  
  test "should redirect to home page if user tries to delete student he does not own" do
    login(:loser)
    delete :destroy, :id => students(:demura).id
    assert_redirected_to root_path
  end
  
end
