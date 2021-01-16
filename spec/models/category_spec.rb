require 'rails_helper'

RSpec.describe Category, type: :model do
  before do
    @category = FactoryBot.build(:category)
  end

  describe 'カテゴリー登録' do
    
    context '新規登録がうまくいくとき' do
      it "categoryが存在すれば登録できる" do
        expect(@category).to be_valid
      end
    end

    context '新規登録できないとき' do
      it "categoryが空では登録できない" do
        @category.id = ''
        @category.valid?
        expect(@category.errors.full_messages).to include("Category must be other than 1")
      end
    end

  end
end
