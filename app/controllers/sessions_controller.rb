class SessionsController < ApplicationController
  before_action :logged_in_new_or_login, only: :new

  def new; end

  def create
    auth = request.env['omniauth.auth']
    if auth.present?
      user = User.find_or_create_from_auth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      flash[:notice] = "ログインしました。"
      redirect_to user
    else # 既存パタン
      user = User.find_by(email: params[:session][:email].downcase)
      if user&.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:notice] = "ログインしました。"
        redirect_back_or user
      else
        flash.now[:alert] = "認証に失敗しました。"
        render :new
      end
    end
  end

  def new_guest
    user = User.guest
    log_in user
    redirect_to user_url(user), notice: '（歯科医院）としてログインしました。'
  end

  def new_admin_guest
    user = User.guest_admin
    log_in user
    redirect_to user_url(user), notice: '（管理者）としてログインしました。'
  end

  def destroy
    log_out if logged_in?
    flash[:notice] = "ログアウトしました。"
    redirect_to root_path
  end
end
