class OrdersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def new
  end
  
  def create
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
    
    def set_user
      @user = User.find(params[:user_id])
    end
end
