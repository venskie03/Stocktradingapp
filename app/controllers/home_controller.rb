class HomeController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_users, only: [:home, :index]

  skip_before_action :authenticate_user!, only: %i[index]
  
  def index
    @users = User.where(broker_status: 'application_pending')
  end

  private

  def set_users
    @users = User.all
  end
end