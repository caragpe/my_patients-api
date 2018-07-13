# frozen_string_literal: true

FactoryBot.define do
  factory :patient do
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    weight 80
    height 182
    mrn { Faker::Number.hexadecimal(6) }
    factory :patient_with_encounters do
      transient do
        encounters_count 2
      end

      after(:create) do |patient, evaluator|
        create_list(:encounter, evaluator.encounters_count, patient: patient)
      end
    end
  end
end
