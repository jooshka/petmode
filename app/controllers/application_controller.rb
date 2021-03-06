class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def after_sign_in_path_for(resource)
    current_user.sign_in_count == 1 ? edit_user_path(current_user) : user_path(current_user)
  end

  def set_locale
    I18n.locale = #(current_user.locale if current_user) ||
                  session[:locale] || I18n.default_locale
  end

end
