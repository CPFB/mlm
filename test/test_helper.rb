ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  
  def login(user = :cpfb)
    @user = users(user)
    @user.confirm!
    sign_in :user, @user
  end
  
  def redirected_to_sign_in?
    assert_redirected_to :controller => "devise/sessions", :action => 'new'
  end
  
  # Add more helper methods to be used by all tests here...
  
  class ActionController::TestCase
    include Devise::TestHelpers
  end
end
