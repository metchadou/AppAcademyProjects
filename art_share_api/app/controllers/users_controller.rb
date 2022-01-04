class UsersController < ApplicationController
  def index
    users = User.all

    if params[:username]
      render json: users.where(username: params[:username])
    else
      render json: users
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: params
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    user = User.find(params[:id])
    success = user.update(user_params)
    
    if success
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: user
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end