class DashboardController < ApplicationController
  def index
  end
  def approve
    user = User.find(params[:id])
    if user
      user.confirmed_at = Time.current
      user.broker_status = :approved
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
