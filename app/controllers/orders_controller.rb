class OrdersController < ApplicationController
  
  before_action :set_user
  
  def new
    @order = Order.new
  end
  
  def create
    @order = @user.orders.build(order_params)
    if params[:order][:first_try].present? && params[:order][:complete_day].present?
      flash.now[:alert] = "試適１ または 完成日 一つに日付を入れてください。"
      render :new
    else  
      if @order.save
        flash[:notice] = "技工指示書を新規作成しました。"
        redirect_to @user
      else
        render :new
      end
    end
  end
  
  def show
    @order = @user.orders.find_by(id: params[:id])
    @content = @order.content
  end
  
  def index
  end
  
  def edit
    @order = @user.orders.find_by(id: params[:id])
    @content = @order.content
  end
  
  def update
    @order = @user.orders.find_by(id: params[:id])
    if @order.update_attributes(order_params)
      flash[:notice] = "指示書を更新しました。"
      redirect_to user_order_url @user, @order
    else
      render :edit
    end
  end
  
  def admin_update
    @order = @user.orders.find_by(id: params[:id])
    if @order.metal.present? && params[:order][:weight].blank? || @order.complete_day.present? && params[:order][:finished] == "false"
      flash.now[:alert] = "必須項目が空欄です。"
      render :show
    else
      @order.update_attributes(order_params)
      flash[:notice] = "技工物の製作が完了しました。"
      redirect_to user_order_url @user, @order
    end
  end
  
  def destroy
  end
  
  private
  
    def order_params
      params.require(:order).permit(:patient_name, :sex, :color, :note, {content: []}, :content_other, :other_text, :crown, :metal, :weight, :first_try, :second_try,
                                    :complete_day, :reception_date, :finished,:image_1, :image_2, :image_3)
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end
end
