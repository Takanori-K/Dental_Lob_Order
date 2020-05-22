class OrdersController < ApplicationController
  
  before_action :set_user
  before_action :correct_user_orders,   only: [:new, :create, :edit, :update]
  before_action :admin_user_order_edit, only: [:new, :create, :edit, :update]
  before_action :admin_or_correct_user, only: [:show, :index]
  before_action :admin_user,            only: :admin_update
  
  def new
    @order = Order.new
  end
  
  def create
    @admin = User.find_by(admin: true)
    @order = @user.orders.build(order_params)
    if @order.save
      flash[:notice] = "技工指示書を新規作成しました。"
      NotificationMailer.complete_mail(@user, @order, @admin).deliver if current_user.email.present?
      redirect_to @user
    else
      render :new
    end
  end
  
  def show
    @order = @user.orders.find_by(id: params[:id])
    @content = @order.content
  end
  
  def pdf
    @admin = User.find_by(admin: true)
    @order = @user.orders.find_by(id: params[:id])
    respond_to do |format|
      format.html { redirect_to action: :pdf, format: :pdf, debug: true }
      format.pdf do
        render pdf: '歯科技工指示書',
               layout: 'pdf.html.erb',
               template: '/orders/pdf.html.erb',
               encording: 'UTF-8',
               page_size:   'A5',
               orientation: 'Landscape',
               show_as_html: params.key?('debug')
      end
    end
  end
  
  def index
    @order = @user.orders.find_by(id: params[:id])
    @orders_finished = Order.where(user_id: @user.id, finished: "true").paginate(page: params[:page], per_page: 60).order(id: "DESC")
    if params[:search].present? && params[:search_day].blank?
      @orders_finished = @orders_finished.where('patient_name LIKE ?', "%#{params[:search]}%").order(:complete_day)
    elsif params[:search].present? && params[:search_day].present?
      @orders_finished = @orders_finished.where('patient_name LIKE ?', "%#{params[:search]}%").where(complete_day: Date.parse("#{params[:search_day]}-01").all_month).order(:complete_day)
    elsif params[:search].blank? && params[:search_day].present?
      @orders_finished = @orders_finished.where(complete_day: Date.parse("#{params[:search_day]}-01").all_month).order(:complete_day)
    end
  end
  
  
  def edit
    @order = @user.orders.find_by(id: params[:id])
    @content = @order.content
  end
  
  def update
    @order = @user.orders.find_by(id: params[:id])
    if @order.update_attributes(order_params)
      flash[:notice] = "指示書を更新しました。"
      redirect_to user_order_url(@user, @order)
    else
      render :edit
    end
  end
  
  def admin_update
    @admin = User.find_by(admin: true)
    @order = @user.orders.find_by(id: params[:id])
    if @order.metal.present? && params[:order][:weight].blank? || @order.complete_day.present? && params[:order][:finished] == "false"
      flash.now[:alert] = "必須項目が空欄です。"
      render :show
    else
      @order.update_attributes(order_params)
      flash[:notice] = "技工物の製作が完了しました。"
      NotificationMailer.complete_order_mail(@user, @order, @admin).deliver
      redirect_to user_url(current_user)
    end
  end
  
  def destroy
    @order = @user.orders.find_by(id: params[:id])
    @order.destroy
    flash[:notice] = "指示書を削除しました。"
    redirect_to user_url(current_user)
  end
  
  private
  
    def order_params
      params.require(:order).permit(:patient_name, :sex, :color, :note, {content: []}, :content_other, :other_text, :crown, :metal, :weight, :first_try, :second_try,
                                    :complete_day, :reception_date, :finished,:image_1, :image_2, :image_3)
    end
    
    def reservation_search_params
      params.fetch(:search, {}).permit(:patient_name, :complete_day)
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end
end
