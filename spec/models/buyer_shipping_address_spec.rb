require 'rails_helper'

RSpec.describe BuyerShippingAddress, type: :model do
  before do
    @buyer_shipping_address = FactoryBot.build(:buyer_shipping_address)
  end

  describe "商品購入登録" do

    context "商品購入ができるとき" do
      it "すべての値が正しく入力されていれば保存できること" do
        expect(@buyer_shipping_address).to be_valid
      end
      it "tokenがあれば保存ができること" do
        expect(@buyer_shipping_address).to be_valid
      end
      it "builiding_nameが空でも保存できること" do
        @buyer_shipping_address.building_name = nil
        expect(@buyer_shipping_address).to be_valid
      end
    end

    context "商品購入ができないとき" do
      it "postal_codeが空だと保存できないこと" do
        @buyer_shipping_address.postal_code = nil
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
        @buyer_shipping_address.municipality = nil
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Municipality can't be blank")
      end
      it "telephone_numberが空では登録できない" do
        @buyer_shipping_address.telephone_number = nil
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Telephone number can't be blank")
      end
      it "telephone_numberが11桁以内でないと保存できないこと" do
        @buyer_shipping_address.telephone_number = '1234567890'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Telephone number is invalid")
      end
      it "telephone_numberは全角では保存ができないこと" do
        @buyer_shipping_address.telephone_number = '１２３４５６７８９００'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Telephone number is invalid")
      end
      it "telephone_numberは半角英数混合だと登録できないこと" do
        @buyer_shipping_address.telephone_number = '123asdf8900'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Telephone number is invalid")
      end
      it "telephone_numberは12桁以上だと登録できないこと" do
        @buyer_shipping_address.telephone_number = "123456789001"
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Telephone number is invalid")
      end
      it "tokenが空では登録できないこと" do
        @buyer_shipping_address.token = ""
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end