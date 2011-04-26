require 'test_helper'

class SchoolTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def setup
    @school = schools(:rhhs)
  end
  
  
  test "valid school is saved" do
    assert @school.save
  end
  
  test "school without name is not saved" do
    @school.school_name = ""
    assert !@school.save
  end
  
  test "schools should have unique names" do
    @school.save
    duplicate = School.new(:school_name => "Rockwall Heath High School")
    assert !duplicate.save
  end
  
  test "should respond to students" do
    assert_respond_to @school, :students
  end
  
  test "#students is an array of students" do
    assert_kind_of Array, @school.students
  end
  
  test "#students lists the correct number of students" do
    assert_equal @school.students.size, 3
  end
  
  test "#students has elements that are of class Student" do
    assert_kind_of Student, @school.students.first
  end
end
