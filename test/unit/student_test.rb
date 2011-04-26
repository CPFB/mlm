require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  def setup
    @student = students(:demura)
  end
  
  test "valid student is saved" do
    assert @student.save
  end
  
  test "student without first name is not saved" do
    @student.first_name = ""
    assert !@student.save
  end
  
  test "student without last name is not saved" do
    @student.last_name = ""
    assert !@student.save
  end
  
  test "student without school is not saved" do
    @student.school = nil
    assert !@student.save
  end
  
  test "student without instructor is not saved" do
    @student.instructor = nil
    assert !@student.save
  end
  
  test "student without email IS saved" do
    @student.email = ""
    assert @student.save
  end
  
  test "responds to school with an instance of school" do
    assert_respond_to @student, :school
    assert_kind_of School, @student.school
  end
  
  test "responds to instructor with an instance of instructor" do
    assert_respond_to @student, :instructor
    assert_kind_of Instructor, @student.instructor
  end
  
  test "responds to school_name" do
    assert_respond_to @student, :school_name
  end
  
  test "school_name returns the name of the school" do
    assert @student.school_name == "Rockwall Heath High School"
  end
  
  test "school_name returns empty string for a new student" do
    student = Student.new
    assert student.school_name == ""
  end
  
  test "responds to full_name properly" do
    assert_respond_to @student, :full_name
    assert @student.full_name == "Michelle Demura"
  end
  
  test "responds to payments properly" do
    assert_respond_to @student, :payments
    assert_kind_of Array, @student.payments
    for payment in @student.payments
      assert_kind_of Payment, payment
    end
  end
  
  test "responds to lessons properly" do
    assert_respond_to @student, :lessons
    assert_kind_of Array, @student.lessons
    for lesson in @student.lessons
      assert_kind_of Lesson, lesson
    end
  end
  
  test "responds to total_payments properly" do
    @student = students(:demura)
    def @student.sum_the_payments_up
      total_payments
    end
    
    assert_equal @student.sum_the_payments_up, 15
  end
  
  test "responds to total_lessons properly" do
    @student = students(:demura)
    def @student.sum_the_lessons_up
      total_lessons
    end
    
    assert_equal @student.sum_the_lessons_up, 15
  end
  
  test "responds to balance_due properly when it should be a zero balance" do
    assert_respond_to @student, :balance_due
    assert_equal @student.balance_due, 0
  end
  
  test "returns proper total when it should be a positive balance" do
    student = students(:cason)
    assert_equal student.balance_due, 15
  end
  
  test "returns proper total when it should be a negative balance" do
    student = students(:johnny)
    assert_equal student.balance_due, -570
  end
  
  test "lessons_with_balance_due returns the lessons with a balance due" do
    student = students(:two_lessons_no_payment)
    for lesson in student.lessons_with_balance_due
      assert_kind_of Lesson, lesson
      assert lesson.balance > 0
    end
  end
  
  test "payments_with_balance_remaining returns the payments with a balance remaining" do
    student = students(:two_payments_no_lessons)
    for payment in student.payments_with_balance_remaining
      assert_kind_of Payment, payment
      assert payment.balance > 0
    end
  end
end
