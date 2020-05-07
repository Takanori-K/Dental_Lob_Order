class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  $days_of_the_week = %w{日 月 火 水 木 金 土}
  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:alert] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
  def logged_in_new_or_login
    if logged_in?
      flash[:alert] = "すでにログインしています。"
      redirect_to current_user
    end
  end
  
  def admin_user_order_edit
    if current_user.admin?
      flash[:danger] = "編集権限がありません。"
      redirect_to root_url
    end
  end

    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
    
  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
