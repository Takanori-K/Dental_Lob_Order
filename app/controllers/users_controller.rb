class UsersController < ApplicationController
  before_action :set_user,               only: %i[show video_room edit update destroy]
  before_action :logged_in_user,         only: %i[index show video_room edit update destroy]
  before_action :ensure_normal_user,     only: :update
  before_action :admin_user,             only: %i[index destroy]
  before_action :logged_in_new_or_login, only: :new
  before_action :admin_or_correct_user,  only: %i[show video_room edit update]

  def index
    @admin_other = User.where.not(admin: true)
    @users = @admin_other.paginate(page: params[:page], per_page: 8).order(:id)
  end

  def show
    @orders = Order.where(user_id: current_user.id).order(id: "DESC")
    @notification_info = Order.where.not(reception_date: nil).where(finished: [nil, "false"])
    @notification = Order.where.not(reception_date: nil).where(finished: [nil, "false"]).count
    @order = @user.orders.find_by(id: params[:id])
    @users = User.where(admin: false)
    @calendar_orders = Order.where.not(reception_date: nil)
    @new = Order.where(user_id: @user.id).where(finished: [nil, "false"])
  end

  def video_room
    gon.skyway_key = ENV['SKYWAY_KEY']
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to user_url(@user), notice: "新規作成に成功しました。"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "ユーザー情報を更新しました。"
      if current_user.admin?
        redirect_to @user
      else
        redirect_to user_url(current_user)
      end
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def destroy_all
    if Order.where(id: params[:order_ids]).destroy_all
      flash[:notice] = "指示書を一括削除しました。"
    else
      flash[:alert] = "指示書を削除できませんでした。"
    end
    redirect_to users_url(@user)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache, :remove_image)
    end

    def uid_params
      params.require(:user).permit(:name, :image, :image_cache, :remove_image)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def ensure_normal_user
      return unless params[:user][:email].downcase == "admin@email.com"

      redirect_to user_path(current_user), alert: "管理者のアカウントは編集できません。"
    end
end
