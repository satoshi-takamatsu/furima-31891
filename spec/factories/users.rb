FactoryBot.define do
  factory :user do
    nickname                 { Faker::Name.initials(number: 6) }
    email                    { Faker::Internet.free_email }
    password                 { Faker::Internet.password(min_length: 6) }
    password_confirmation    { password }
    last_name                { Gimei.last }
    first_name               { Gimei.first }
    last_name_kana           { Gimei.last.katakana }
    first_name_kana          { Gimei.first.katakana }
    birthday                 { Faker::Date.birthday }
  end
end