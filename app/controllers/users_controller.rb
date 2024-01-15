class UsersController < ApplicationController
  def index

  end
  def create
    # Assuming you have a form or some way to collect user parameters
    user_params = {
      username: params[:username],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      balance: params[:balance]
    }
    # Create a new user using Devise's registration method
    @user = User.new(user_params)
    if @user.save
      @user.update(confirmed_at: Time.current, broker_status: :approved)
      UserMailer.account_created(@user).deliver_now
      redirect_to create_new_user_path, notice: 'User created successfully'
    else
      render :new
    end
  end
end
