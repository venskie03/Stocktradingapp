class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

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

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :role, :email, :password, :password_confirmation])
        devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :role, :email, :password, :password_confirmation, :current_password])
      end
end