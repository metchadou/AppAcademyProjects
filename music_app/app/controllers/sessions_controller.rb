class SessionsController < ApplicationController
  def new
    render :new
  end
  
  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password])

    if user.nil?
      flash.now[:errors] = ["Invalid email and/or password"]
      render :new
    else
      login_user!(user)
      redirect_to bands_url
    end
  end

  def destroy
    logout!(current_user)
    redirect_to new_session_url
  end
end