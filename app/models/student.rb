class Student < ActiveRecord::Base
  belongs_to :school
  belongs_to :instructor
  has_many :payments
  has_many :lessons
  
  validates_presence_of :first_name, :last_name, :school, :instructor
  
  def school_name
    self.school ? self.school.school_name : ""
  end
  
  def full_name
    self.first_name + ' ' + self.last_name
  end
  
  def balance_due
    total_lessons - total_payments
  end
  
  def lessons_with_balance_due
    self.lessons.where("balance > ?", 0).order("datetime ASC")
  end
  
  def payments_with_balance_remaining
    self.payments.where("balance > ?", 0).order("date ASC")
  end
  
  
  
  private
  
    def total_payments
      total = 0
      for payment in self.payments
        total += payment.amount
      end
      return total
    end
    
    def total_lessons
      total = 0
      for lesson in self.lessons
        total += lesson.charge
      end
      return total
    end
  
end
