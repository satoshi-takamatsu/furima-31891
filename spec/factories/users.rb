FactoryBot.define do
  factory :user do
    nickname                 { Faker::Name.initials(number: 6) }
    email                    { Faker::Internet.free_email }
    password                 { '1a' + Faker::Internet.password(min_length: 6) } # 記憶の定着の為に記述 '1a'を追加することにより確実に半角英数字がダミー生成される
    password_confirmation    { password }

    gimei = Gimei.name
    last_name                { Gimei.last }
    first_name               { Gimei.first }
    last_name_kana           { Gimei.last.katakana }
    first_name_kana          { Gimei.first.katakana }
    birthday                 { Faker::Date.birthday }
  end
end