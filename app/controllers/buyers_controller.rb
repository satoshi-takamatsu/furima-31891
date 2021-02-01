class BuyersController < ApplicationController
  
  def index
    @item = Item.find(params[:item_id])
  end

  def new
    @buyer_shipping_address = BuyerShippingAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @buyer_shipping_address = BuyerShippingAddress.new(buyer_params)
    if @buyer_shipping_address.valid?
      @buyer_shipping_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  
  def buyer_params
    params.permit(:postal_code, :shipping_area_id, :municipality, :street_number, :building_name, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
