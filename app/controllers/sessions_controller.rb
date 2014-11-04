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
    if @user
      signin!(@user)
      redirect_to root_url
    else
      flash[:errors] = 'Username or password is invalid'
      render :new
    end
  end
end
