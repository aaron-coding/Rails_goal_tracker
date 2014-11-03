class SessionsController < ApplicationController
  def new
    
  end
  
  def destroy
    signout!(current_user)
    redirect_to root_url
  end
  
  def create
    @user = User.find_by_credentials(
       params[:user][:username],
       params[:user][:password]
    )
    if @user.nil?
      render :new
    else
      signin!(@user)
      redirect_to root_url
    end
  end
end
