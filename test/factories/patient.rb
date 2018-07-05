FactoryBot.define do
  factory :patient do
    first_name Faker::Name.first_name
    middle_name Faker::Name.middle_name
    last_name Faker::Name.last_name
    weight 80
    height 1.80
    mrn Faker::Code.imei
  end
end
