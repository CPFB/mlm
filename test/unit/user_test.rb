require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  def setup
    @user = users(:cpfb)
  end
  
  test "valid user is saved" do
    assert @user.save
  end
  
  test "user without first name is not saved" do
    @user.first_name = ""
    assert !@user.save
  end
  
  test "user without last name is not saved" do
    @user.last_name = ""
    assert !@user.save
  end
  
  test "responds to instructor" do
    instructor = instructors(:cpfb)
    assert @user.instructor == instructor
  end
  
  test "responds to admin?" do
    assert_respond_to @user, :admin?
  end

  test "regular user is not an admin" do
    assert !@user.admin?
  end
  
  test "admin user is an admin" do
    assert users(:admin).admin?
  end
  
  test "recent_payments returns 5 most recent payments" do
    user = users(:six)
    assert_equal user.recent_payments.size, 5
    assert_equal user.recent_payments[0].date, Date.parse("2011-01-06")
    assert_equal user.recent_payments[1].date, Date.parse("2011-01-05")
    assert_equal user.recent_payments[2].date, Date.parse("2011-01-04")
    assert_equal user.recent_payments[3].date, Date.parse("2011-01-03")
    assert_equal user.recent_payments[4].date, Date.parse("2011-01-02")
  end
  
  test "recent_lessons returns 5 most recent lessons" do
    user = users(:six)
    assert_equal user.recent_lessons.size, 5
    assert_equal user.recent_lessons[0].datetime, DateTime.parse("2011-01-06 00:00:00")
    assert_equal user.recent_lessons[1].datetime, DateTime.parse("2011-01-05 00:00:00")
    assert_equal user.recent_lessons[2].datetime, DateTime.parse("2011-01-04 00:00:00")
    assert_equal user.recent_lessons[3].datetime, DateTime.parse("2011-01-03 00:00:00")
    assert_equal user.recent_lessons[4].datetime, DateTime.parse("2011-01-02 00:00:00")
  end
  
end
