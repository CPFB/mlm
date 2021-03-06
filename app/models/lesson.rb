class Lesson < ActiveRecord::Base
  belongs_to :student
  belongs_to :instructor
    
  validates_presence_of :student, :datetime, :charge
  validates_numericality_of :charge, :greater_than_or_equal_to => 0
  
  def set_balance
    lesson_balance = charge
    for payment in self.student.payments_with_balance_remaining
      payment_balance = payment.balance
      if lesson_balance >= payment_balance
        lesson_balance -= payment_balance
        payment_balance = 0
      else
        payment_balance -= lesson_balance
        lesson_balance = 0
      end
      payment.update_attributes(:balance => payment_balance)
    end
    update_attributes(:balance => lesson_balance)
  end
end
