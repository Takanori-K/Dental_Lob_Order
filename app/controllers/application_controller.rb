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
      flash[:danger] = "アクセス権限がありません。"
      redirect_to root_url
    end
  end
  
  def admin_or_correct_user
    @user = User.find(params[:user_id]) if @user.blank?
    unless current_user?(@user) || current_user.admin?
      flash[:alert] = "アクセス権限がありません。"
      redirect_to(root_url)
    end
  end
  
  def correct_user_orders
    @user = User.find(params[:user_id]) if @user.blank?
    unless current_user?(@user)
      flash[:alert] = "アクセス権限がありません。"
      redirect_to(root_url)
    end
  end

    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      flash[:alert] = "アクセス権限がありません。"
      redirect_to(root_url)
    end  
  end
    
  def admin_user
    unless current_user.admin?
      flash[:alert] = "アクセス権限がありません。"
      redirect_to(root_url)
    end
  end
end
