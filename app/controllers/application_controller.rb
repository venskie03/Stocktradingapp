class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User) && !resource_or_scope.confirmed?
      flash[:notice] = 'Your account is not yet confirmed. Please wait for approval.'
      root_path
    else
      super
    end
  end
end
