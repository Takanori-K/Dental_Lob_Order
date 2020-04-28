class OrdersController < ApplicationController
  
  before_action :set_user
  
  def new
    @order = Order.new
  end
  
  def create
    @order = @user.orders.build(order_params)
    if @order.save
      flash[:notice] = "技工指示書を新規作成しました。"
      redirect_to @user
    else
        render :new
    end
  end
  
  def show
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
      params.require(:order).permit(:patient_name, :sex, :color, :note, {content: [].join(",")}, :content_other, :other_text, :crown, :metal, :first_try, :second_try,
                                    :complete_day, :reception_date, :weight, :finished,:image_1, :image_2, :image_3)
    end                                
    
    def set_user
      @user = User.find(params[:user_id])
    end
end
