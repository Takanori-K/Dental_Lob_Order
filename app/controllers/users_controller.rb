class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: :update
  before_action :admin_user, only: [:index, :destroy]
  
  def index
    @admin_other = User.where.not(admin: true)
    @users = @admin_other.paginate(page: params[:page], per_page: 8)
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
  
  def edit 
  end
  
  def update
    if @user.update_attributes(user_params)
      redirect_to @user, notice: "ユーザー情報を更新しました。"
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
      redirect_to users_url(@user)
    else
      flash[:alert] = "指示書を削除できませんでした。"
      redirect_to users_url(@user)
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
end
