  class DashboardController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_users, only: [:home, :index]

  def index
    @user_stocks = current_user.user_stocks
    @users = User.where(broker_status: 'application_pending')
  end

  private
  def set_users
    @users = User.all
  end
    end
