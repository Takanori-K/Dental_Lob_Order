class UsersController < ApplicationController
  def new
  end
  
  def facebook_login
    @user = User.from_omniauth(request.env["omniauth.auth"])
      result = @user.save(context: :facebook_login)
      if result
        log_in @user
        redirect_to @user
      else
        redirect_to auth_failure_path
      end
  end

  #認証に失敗した際の処理
  def auth_failure 
    @user = User.new
    render '任意のアクション'
  end
end
