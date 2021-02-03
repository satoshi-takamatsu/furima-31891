class BuyersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @item = Item.find(params[:item_id])
    @buyer_shipping_address = BuyerShippingAddress.new
  end 

  def new
    @buyer_shipping_address = BuyerShippingAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @buyer_shipping_address = BuyerShippingAddress.new(buyer_params)
    if @buyer_shipping_address.valid?
      pay_item
      @buyer_shipping_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def buyer_params
    params.require(:buyer_shipping_address).permit(:postal_code, :shipping_area_id, :municipality, :street_number, :building_name, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp::api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: buyer_params[:token],
      currency: 'jpy'
    )
  end

  def authenticate_user!
    if user_signed_in?
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

end
