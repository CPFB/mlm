class PaymentsController < ApplicationController
  before_filter :redirect_if_not_logged_in
  load_and_authorize_resource
  
  def index
    @payments = Payment.where(:instructor_id => current_user.instructor)
  end
  
  def new
    @students = Student.where(:instructor_id => current_user.instructor)
  end
  
  def create
    # payment_balance = @payment.amount
    # for lesson in @payment.student.lessons_with_balance_due
    #   lesson_balance = lesson.balance
    #   if payment_balance >= lesson_balance
    #     payment_balance -= lesson_balance
    #     lesson_balance = 0
    #   else
    #     lesson_balance -= payment_balance
    #     payment_balance = 0
    #   end
    #   lesson.update_attributes(:balance => lesson_balance)
    # end   
    # @payment.balance = payment_balance
    
    # @payment.set_balance
    
    if @payment.save
      redirect_to root_path, :notice => "Payment saved successfully."
    else
      render :new, :notice => "There was a problem saving this payment."
    end
  end
  
  def show
    
  end
  
  def edit
    @students = Student.where(:instructor_id => current_user.instructor)
  end
  
  def update
    if @payment.update_attributes(params[:payment])
      redirect_to root_path, :notice => "Payment updated successfully."
    else
      render :edit, :notice => "There was a problem saving the changes to this payment."
    end
  end
  
  def destroy
    @payment.destroy
    redirect_to root_path, :notice => "Payment deleted."
  end
  
  
  
end
