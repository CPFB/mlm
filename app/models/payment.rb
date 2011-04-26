class Payment < ActiveRecord::Base
  belongs_to :student
  belongs_to :instructor
  
  validates_presence_of :student, :instructor, :date, :amount, :payment_type
  
  # def set_balance
  #   balance = self.amount
  #   if self.student.lessons_with_balance_due.size > 0
  #     for lesson in self.student.lessons_with_balance_due
  #       if balance >= lesson.balance
  #         balance -= lesson.balance
  #         lesson.balance = 0
  #       else
  #         lesson.balance -= balance
  #         balance = 0
  #       end
  #       lesson.save
  #     end
  #   end
  # end
  
  after_create :set_balance
  
  def set_balance
    payment_balance = amount
    for lesson in student.lessons_with_balance_due
      lesson_balance = lesson.balance
      if payment_balance >= lesson_balance
        payment_balance -= lesson_balance
        lesson_balance = 0
      else
        lesson_balance -= payment_balance
        payment_balance = 0
      end
      lesson.update_attributes(:balance => lesson_balance)
    end   
    update_attributes(:balance => payment_balance)
  end
end