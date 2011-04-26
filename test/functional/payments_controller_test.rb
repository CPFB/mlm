require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase

  def setup
    @payment_hash = {
      :student => students(:demura),
      :instructor => instructors(:cpfb),
      :date => "2011-04-19",
      :amount => "15.00",
      :payment_type => "check",
      :check_number => "1555",
      :notes => "Payment made on time."
    }
  end
  
  
  test "should get index when signed in" do
    login
    get :index
    assert_response :success
  end
  
  test "should redirect to sign in page when not logged in and trying to access index" do
    get :index
    redirected_to_sign_in?
  end
  
  test "should get new when signed in" do
    login
    get :new
    assert_response :success
  end
  
  test "should redirect to sign in page when not logged in and trying to access new" do
    get :new
    redirected_to_sign_in?
  end
  
  test "should create new payment on create action" do
    login
    assert_difference('Payment.count') do
      post :create, :payment => @payment_hash
    end
  end
  
  test "should show when logged in and payment belongs to the user" do
    login
    get :show, :id => payments(:one).id
    assert_response :success
  end
  
  test "should show when logged in as an admin user" do
    login(:admin)
    get :show, :id => payments(:one).id
    assert_response :success
  end
  
  test "should redirect to root path when trying to access show action and user does not own the payment" do
    login(:loser)
    get :show, :id => payments(:one).id
    assert_redirected_to root_path
  end
  
  test "should access edit action when payment belongs to user" do
    login
    get :edit, :id => payments(:one).id
    assert_response :success
  end
  
  test "should access edit action when user is admin" do
    login(:admin)
    get :edit, :id => payments(:one).id
    assert_response :success
  end
  
  test "should redirect to root path when trying to access edit action and user does not own the payment" do
    login(:loser)
    get :edit, :id => payments(:one).id
    assert_redirected_to root_path
  end
  
  # test "should update"
  # HASN'T WORKED FOR ANY OF THE OTHER ACTIONS; INVESTIGATE
  
  test "should delete payment that user owns" do
    login
    assert_difference('Payment.count', -1) do
      delete :destroy, :id => payments(:one).id
    end
  end
  
  test "should delete payment if user is admin" do
    login(:admin)
    assert_difference('Payment.count', -1) do
      delete :destroy, :id => payments(:one).id
    end
  end
  
  test "should not delete payment if user does not own payment" do
    login(:loser)
    assert_difference('Payment.count', 0) do
      delete :destroy, :id => payments(:one).id
    end
    assert_redirected_to root_path
  end
  
  # test "should make balance 0 for both lesson and payment when creating a payment that cancels out another" do
  #   lesson = lessons(:equal)
  #   lesson.set_balance
  #   login
  #   @payment_hash[:student] = students(:equal)
  #   post :create, :payment => @payment_hash
  #   assert_equal lesson.balance, 0
  #   payment = Payment.last
  #   # assert_equal payment.balance, 0
  # end
end
