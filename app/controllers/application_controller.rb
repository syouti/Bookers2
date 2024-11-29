class ApplicationController < ActionController::Base
  # Deviseのストロングパラメーター設定（必要に応じて）
  before_action :authenticate_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # ログイン後のリダイレクト先を設定
  def after_sign_in_path_for(resource)
    user_path(resource) # ログインしたユーザーの詳細ページにリダイレクト
  end

  # Devise用のストロングパラメーター設定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email])
  end
end
