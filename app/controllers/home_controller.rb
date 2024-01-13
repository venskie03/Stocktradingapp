  class DashboardController < ApplicationController
    before_action :authenticate_admin!, only: [:approve_user]
    def index
      @users = User.all
      @user_stocks = current_user.user_stocks
    end

    def approve_user
      user = User.find(params[:id])
      user.confirmed_at = Time.current
      user.broker_status = :approved
      if user.save
        ApplicationMailer.account_approved_email(user).deliver_later
        flash[:success] = "User #{user.username}'s account has been approved."
      else
        flash[:error] = "Failed to approve user #{user.username}'s account."
      end
      redirect_to dashboard_index_path
    end


    end
