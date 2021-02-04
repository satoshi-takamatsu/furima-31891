class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :buyer_set_item, only: [:index, :create]
  before_action :buyer_set_shipping_address, only: :index
  
  def index
    if @item.user_id == current_user.id || @item.buyer.present?
      redirect_to root_path
    end
  end 

  def create
    # @item = Item.find(params[:item_id]) 記憶の定着の為 before_actionでまとめる
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

  def buyer_set_item
    @item = Item.find(params[:item_id])
  end

  def buyer_set_shipping_address
    @buyer_shipping_address = BuyerShippingAddress.new
  end

end
