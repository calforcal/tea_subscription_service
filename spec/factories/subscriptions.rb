FactoryBot.define do
  factory :subscription do
    title { Faker::Tea.variety }
    price { Faker::Commerce.price(range: 1.0..1000000.0) }
    status { Faker::Boolean.boolean }
    frequency { (0..5).to_a.sample }
    customer_id { (1..3).to_a.sample }
    tea_id { (1..10).to_a.sample }
  end
end
