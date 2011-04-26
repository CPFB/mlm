require 'test_helper'

class LessonTest < ActiveSupport::TestCase
  def setup
    @lesson = lessons(:one)
    @student = students(:demura)
    @instructor = instructors(:cpfb)
  end
  
  test "responds to student properly" do
    assert_respond_to @lesson, :student
    assert @lesson.student == @student
  end
  
  test "responds to instructor properly" do
    assert_respond_to @lesson, :instructor
    assert @lesson.instructor == @instructor
  end
  
  test "valid lesson is saved" do
    assert @lesson.save
  end
  
  test "lesson with no student is not saved" do
    @lesson.student = nil
    assert !@lesson.save
  end
  
  test "lesson with no datetime is not saved" do
    @lesson.datetime = nil
    assert !@lesson.save
  end
  
  test "lesson with no charge is not saved" do
    @lesson.charge = ""
    assert !@lesson.save
  end
  
  test "lesson with non-numeric charge is not saved" do
    @lesson.charge = "fifteen"
    assert !@lesson.save
  end
  
  test "lesson with negative charge is not saved" do
    @lesson.charge = "-15.00"
    assert !@lesson.save
  end
  
  # testing the set balance method
  test "lesson with no payments pending has a balance equal to the balance" do
    student = students(:one)
    # this step will be done in the controller
    lesson = student.lessons.first
    lesson.set_balance
    lesson.save
    assert_equal lesson.balance, 15.00
  end

  # test "lesson with equal payment sets balance of lesson to zero when lesson is entered first" do
  #   student = students(:equal)
  #   lesson = student.lessons.first
  #   lesson.set_balance
  #   lesson.save
  #   assert_equal lesson.balance, 15
  #   payment = student.payments.first
  #   
  #   # payment.set_balance
  #   
  #   payment_balance = payment.amount
  #   for lesson in payment.student.lessons_with_balance_due
  #     lesson_balance = lesson.balance
  #     if payment_balance >= lesson_balance
  #       payment_balance -= lesson_balance
  #       lesson_balance = 0
  #     else
  #       lesson_balance -= payment_balance
  #       payment_balance = 0
  #     end
  #     # assert lesson.valid?
  #     lesson.update_attributes(:balance => lesson_balance)
  #   end   
  #   payment.update_attributes(:balance => payment_balance)
  #   
  #   
  #   payment.save
  #   assert_equal payment.balance, 0
  #   assert_equal lesson.balance, 0
  # end
  
  # test "lesson with equal payment when lesson is made first should have zero balance" do
  #   student = students(:equal)
  #   lesson = student.lessons.first
  #   lesson.set_balance
  #   lesson.save
  #   payment = student.payments.first
  #   payment.set_balance
  #   payment.save
  #   assert_equal payment.balance, 0.00
  #   assert_equal lesson.balance, 0.00
  # end
end
