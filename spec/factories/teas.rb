FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature { Faker::Number.within(range: 175..210) }
    brew_time { Faker::Number.within(range: 5..15) }
  end
end
