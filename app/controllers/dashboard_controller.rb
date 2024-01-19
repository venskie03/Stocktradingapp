class DashboardController < ApplicationController
  def index
    @user_stocks = current_user.user_stocks
  end
  def disapprove
    @user = User.find(params[:id])
    @user.update(user_status: 'disapproved')
    UserMailer.account_disapproved(@user).deliver_now
    redirect_to '/'
    flash[:disapproved] = "User #{@user.username}'s account has been disapproved."
  end

  def approve
    user = User.find(params[:id])
    if user
      user.confirmed_at = Time.current
      user.user_status = :approved
      if user.save
        UserMailer.account_approved(user).deliver_now
        flash[:success] = "User #{user.username}'s account has been approved."
      else
        flash[:error] = "Failed to approve user #{user.username}'s account."
      end
    else
      flash[:error] = "User not found."
    end
    redirect_to '/'
  end
end
