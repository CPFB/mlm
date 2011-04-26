require 'test_helper'

class PaymentTest < ActiveSupport::TestCase

  def setup
    @payment = payments(:one)
  end
  

  test "payment responds to student properly" do
    assert_respond_to @payment, :student
    assert_equal @payment.student, students(:demura)
  end
  
  test "payment responds to instructor properly" do
    assert_respond_to @payment, :instructor
    assert_equal @payment.instructor, instructors(:cpfb)
  end
  
  test "valid payment is saved" do
    assert @payment.save
  end
  
  test "payment with no student is not saved" do
    @payment.student_id = nil
    assert !@payment.save
  end
  
  test "payment with no instructor is not saved" do
    @payment.instructor_id = nil
    assert !@payment.save
  end
  
  test "payment with no date is not saved" do
    @payment.date = nil
    assert !@payment.save
  end
  
  test "payment with no amount is not saved" do
    @payment.amount = nil
    assert !@payment.save
  end
  
  test "payment with no payment_type is not saved" do
    @payment.payment_type = nil
    assert !@payment.save
  end
  
  # testing set_balance method
  test "balance for student with one payment and no lessons is equal to the amount of the payment" do
    student = students(:no_lessons)
    # will be handled by controller in actual application
    payment = student.payments.first
    payment.set_balance
    payment.save
    assert_equal payment.balance, 15
  end
end
