FactoryBot.define do
  factory :buyer_shipping_aaddress do
    postal_code
    shipping_area_id        { Faker::Number.between(from: 2, to: 48) }
    municipality
    street_number
    building_name
    telephone_number        { Faker::Number.leading_zero_number(digits: 11) }
  end
end