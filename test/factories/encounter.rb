FactoryBot.define do
  factory :encounter do
    visit_number { Faker::Number.number(8) }
    location { Faker::Name.initials }
    room { Faker::Number.number(2) }
    bed { Faker::Number.digit }
    admitted_at { Faker::Time.backward(1, :morning) }
  end
end
