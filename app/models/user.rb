class User < ActiveRecord::Base
  has_one :instructor
  # Devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  validates_presence_of :first_name, :last_name
  
  def admin?
    self.admin
  end
  
  def full_name
    first_name + ' ' + last_name
  end
  
  def recent_payments
    all_payments = self.instructor.payments
    all_payments.sort! { |a,b| b.date <=> a.date }
    array = []
    for num in [0..4]
      array[num] = all_payments[num]
    end
    return array
  end
  
  def recent_lessons
    all_lessons = self.instructor.lessons
    all_lessons.sort! { |a,b| b.datetime <=> a.datetime }
    array = []
    for num in [0..4]
      array[num] = all_lessons[num]
    end
    return array
  end
  
  
  
  
end
