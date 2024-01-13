class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :authenticate_user!

    helper_method :resource, :resource_name, :devise_mapping

    def resource_name
        :user
    end

    def resource
        @resource ||= User.new
    end

    def devise_mapping
        @devise_mapping ||= Devise.mappings[:user]
    end

    def after_sign_in_path_for(*)
        if current_user.role? :admin
            admin_dashboard_index_path
        else
            dashboard_index_path
        end
    end
end
