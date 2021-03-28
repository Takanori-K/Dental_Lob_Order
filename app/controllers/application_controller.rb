class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    return if logged_in?

    store_location
    flash[:alert] = "ログインしてください。"
    redirect_to login_url
  end

  def logged_in_new_or_login
    return unless logged_in?

    flash[:alert] = "すでにログインしています。"
    redirect_to current_user
  end

  def admin_user_order_edit
    return unless current_user.admin?

    redirect_to error_top_url
  end

  def admin_or_correct_user
    @user = User.find(params[:user_id]) if @user.blank?
    return if current_user?(@user) || current_user.admin?

    redirect_to error_top_url
  end

  def correct_user_orders
    @user = User.find(params[:user_id]) if @user.blank?
    return if current_user?(@user)

    redirect_to error_top_url
  end

    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
  def correct_user
    @user = User.find(params[:id])
    return if current_user?(@user)

    redirect_to error_top_url
  end

  def admin_user
    return if current_user.admin?

    redirect_to error_top_url
  end

  def finished_edit
    @user = User.find(params[:user_id])
    @order = @user.orders.find_by(id: params[:id])
    return unless current_user?(@user) && @order.finished == "true"

    flash[:alert] = "完了した指示書を編集することはできません。"
    redirect_to(current_user)
  end
end
