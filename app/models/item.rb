class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :delivery_fee
  belongs_to :shipping_area
  belongs_to :day_to_ship

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name,          length: { maximum: 40 }
    validates :description,   length: { maximum: 1000 }
    validates :price,         numericality: {only_ineger: true, greater_than:300, less_than:9999999 }
    validates :image
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :state_id
    validates :delivery_fee_id
    validates :shipping_area_id
    validates :day_to_ship_id
  end

  def was_attached?
    self.image.attached?
  end

end
