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
  end
  
  def index
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
    def order_params
      params.require(:order).permit(:patient_name, :sex, :color, :note, {content: []}, :content_other, :other_text, :crown, :metal, :first_try, :second_try,
                                    :complete_day, :reception_date, :weight, :finished,:image_1, :image_2, :image_3)
    end                                
    
    def set_user
      @user = User.find(params[:user_id])
    end
end
