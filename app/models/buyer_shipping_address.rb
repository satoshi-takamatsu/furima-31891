class BuyerShippingAddress

  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :shipping_area_id, :municipality, :street_number, :building_name, :telephone_number, :token

  with_options presence: true do
    validates :postal_code,      format: { with: /\A\d{3}[-]\d{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :shipping_area_id, numericality: { other_than: 1 }
    validates :municipality,     format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: "is invalid. Input full-width characters." }
    validates :street_number    # format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    validates :telephone_number, format: { with: /\A\d{11}\z/ }
    validates :token
  end

  def save
    Buyer.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, shipping_area_id: shipping_area_id, municipality: municipality, street_number: street_number, building_name: building_name, telephone_number: telephone_number, buyer_id: user_id )
  end
end