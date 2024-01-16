class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(edit_user)
      UserMailer.account_updated(@user).deliver_now
      flash[:success_updated] = "Successfully Updated Users"
      redirect_to edit_users_path
    else
      flash[:error_update] = "Failed to Updated Task "
      redirect_to edit_users_path
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to "/"
  end

  def create
    user_params = {
      username: params[:username],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      balance: params[:balance]
    }
    @user = User.new(user_params)
    if @user.save
      @user.update(confirmed_at: Time.current, broker_status: :approved)
      UserMailer.account_created(@user).deliver_now
      redirect_to create_new_user_path, notice: 'User created successfully'
    else
      render :new
    end
  end
private
def edit_user
  params.require(:user).permit(:username, :email, :balance)
end
end
