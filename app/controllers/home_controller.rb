class DashboardController < ApplicationController
  def index
    @user_stocks = current_user.user_stocks

    if current_user.admin?
      @users_to_confirm = User.where(broker_status: :application_pending)
      puts "@users_to_confirm: #{@users_to_confirm.inspect}" # Debug output
    else
      @users_to_confirm = []
    end
  end
  end
