class UsersController < ApplicationController
  def new
    render :new
  end
  
  def home
    render :home
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      signin!(@user)
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @goals = current_user == @user ? @user.goals : @user.public_goals
    @comments = @user.comments
    render :show
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
