require 'test_helper'

class InstructorTest < ActiveSupport::TestCase

  def setup
    @instructor = instructors(:cpfb)
  end
  
  test "responds to user" do
    assert_respond_to @instructor, :user
  end
  
  test "result of #user is an instance of user" do
    assert_kind_of User, @instructor.user
  end
  
  test "responds to students" do
    assert_respond_to @instructor, :students
  end
  
  test "result of #students is an array of students" do
    assert_kind_of Array, @instructor.students
    assert_kind_of Student, @instructor.students.first
  end
  
end
