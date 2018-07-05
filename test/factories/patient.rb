FactoryBot.define do
  factory :patient do
    first_name { Faker::Name.name }
    middle_name { Faker::Name.name }
    last_name { Faker::Name.name }
    weight 80
    height 1.80
    mrn { Faker::Code.imei }
  end
end
