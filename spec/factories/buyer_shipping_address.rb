FactoryBot.define do
  factory :buyer_shipping_address do
    postal_code             { '123-4567' }
    shipping_area_id        { Faker::Number.between(from: 2, to: 48) }
    municipality            { Gimei::city.kanji }
    street_number           { '青山1-1-1' }
    building_name           { '柳ビル103' }
    telephone_number        { Faker::Number.leading_zero_number(digits: 11) }
    token                   { "tok_abcdefghijk00000000000000000"}
    user_id                 { '1' }
    item_id                 { '1' }
  end
end