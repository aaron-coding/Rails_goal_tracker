class GoalsController < ApplicationController
  before_action :ensure_logged_in, only: [:new, :create]
  
  def new
    render :new
  end
  
  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to user_url(@goal.achiever)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end
  
  private
  
  def goal_params
    params.require(:goal).permit(:goal, :top_secret)
  end
  
  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end
end
