require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "商品新規登録" do

    context "商品新規登録できるとき" do
      it "nameとdescription、price、image、category_id、state_id、delivery_fee_id、shipping_area_id、day_to_ship_idが存在すれば登録できる" do
        expect(@item).to be_valid
      end
    end

    context "商品新規登録できないとき" do
      it "nameが空では登録できない" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "descriptionが空では登録できない" do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it "priceが空では登録できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "priceが全角では登録できない" do
        @item.price = "１２３４"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "priceが300以下では登録できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than 299")
      end
      it "priceが9,999,999以上では登録できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than 10000000")
      end
      it "priceは半角英数字混合では登録できない" do
        @item.price = "1a2s3d"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "priceは半角英語だけでは登録できない" do
        @item.price = "aabbcc"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "category_idが空では登録できない" do
        @item.category_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Category is not a number")
      end
      it "category_idが1では登録できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it "state_idが空では登録できない" do
        @item.state_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("State is not a number")
      end
      it "state_idが1では登録できない" do
        @item.state_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("State must be other than 1")
      end
      it "delivery_fee_idが空では登録できない" do
        @item.delivery_fee_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee is not a number")
      end
      it "delivery_fee_idが1では登録できない" do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee must be other than 1")
      end
      it "shipping_area_idが空では登録できない" do
        @item.shipping_area_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping area is not a number")
      end
      it "shipping_area_idが1では登録できない" do
        @item.shipping_area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping area must be other than 1")
      end
      it "day_to_ship_idが空では登録できない" do
        @item.day_to_ship_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Day to ship is not a number")
      end
      it "day_to_ship_idが1では登録できない" do
        @item.day_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Day to ship must be other than 1")
      end
      it "ユーザーが紐付いていないと保存できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end

