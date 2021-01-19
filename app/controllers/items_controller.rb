class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]
  
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  # 記憶の定着の為 before_actionを使いインスタンス変数の定義をまとめる
  def show
  end

  def edit
    unless @item.user_id == current_user.id
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      render :show
    else
      render :edit
    end
  end

  def destroy
    if user_signed_in?
      if @item.user_id == current_user.id
        @item.destroy
        redirect_to root_path
      end
    else
      redirect_to new_user_session_path
    end
  end
  # /記憶の定着の為 before_actionを使いインスタンス変数の定義をまとめる

  private
  
  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :category_id, :state_id, :delivery_fee_id, :shipping_area_id, :day_to_ship_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  # 記憶の定着として残しております。 
  # authenticate_user! deviseのヘルパーメソッドで定義されている、下記の記述はいらない。before_actionに指定すればOK
  # def authenticate_user!
  #   unless user_signed_in?
  #     redirect_to new_user_session_path
  #   end
  # end

end