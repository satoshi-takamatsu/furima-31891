FactoryBot.define do
  factory :item do
    user
    name                    { Faker::Commerce.product_name }
    description             { Faker::String.random(length: 1..1000) }
    price                   { Faker::Number.between(from: 300, to: 9999999) }
    category_id             { Faker::Number.between(from: 2, to: 11)}
    state_id                { Faker::Number.between(from: 2, to: 7)}
    delivery_fee_id         { Faker::Number.between(from: 2, to: 3)}
    shipping_area_id        { Faker::Number.between(from: 2, to: 48)}
    day_to_ship_id          { Faker::Number.between(from: 2, to: 4)}


    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png' )
    end
  end
end
