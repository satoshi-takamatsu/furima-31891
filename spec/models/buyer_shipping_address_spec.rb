require 'rails_helper'

RSpec.describe BuyerShippingAddress, type: :model do
  before do
    @buyer_shipping_address = FactoryBot.build(:buyer_shipping_address)
  end

  describe "商品購入機能" do

    context "商品購入ができるとき" do
      it "すべての値が正しく入力されていれば保存できること" do
        expect(@buyer_shipping_address).to be_valid
      end
      it "builiding_nameが空でも保存できること" do
        @buyer_shipping_address.building_name = ""
        expect(@buyer_shipping_address).to be_valid
      end
    end

    context "商品購入ができないとき" do
      it "postal_codeが空だと保存できないこと" do
        @buyer_shipping_address.postal_code = ""
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it "postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと" do
        @buyer_shipping_address.postal_code = '1234567'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it "shipping_area_idが空では登録できない" do
        @buyer_shipping_address.shipping_area_id = ""
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Shipping area is not a number")
      end
      it "shipping_area_idが1では登録できない" do
        @buyer_shipping_address.shipping_area_id = 1
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Shipping area must be other than 1")
      end
      it "municipalityが空では登録できない" do
        @buyer_shipping_address.municipality = ""
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Municipality can't be blank")
      end

      it "telephone_numberが空では登録できない" do
        @buyer_shipping_address.telephone_number = ""
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Telephone number can't be blank")
      end
      it "telephone_numberが11桁以内でないと保存できないこと" do
        @buyer_shipping_address.telephone_number = '12345678'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Telephone number is invalid")
      end
      it "telephone_numberは全角では保存ができないこと" do
        @buyer_shipping_address.telephone_number = '１２３４５６７８９００'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Telephone number is invalid")
      end
    end
    
  end
end