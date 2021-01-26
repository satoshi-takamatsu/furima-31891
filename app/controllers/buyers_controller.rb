class BuyersController < ApplicationController
  
  def index
    # binding.pry
    @buyer = Item.find(params[:item_id])
    @item = Item.new
  end

  def new
  end

  def create
  end

  private
  def buyer_params
    params.require(:buyer).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
