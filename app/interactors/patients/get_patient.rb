# frozen_string_literal: true

class Patients::GetPatient < BaseInteractor
  REQUIRED_PARAMS = %w[id].freeze

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    context.patient_id = id

    if patient = PatientRepository.find_by_id!(context.patient_id)
      context.patient = patient
    else
      context.fail!(message: "There is no patient with ID #{id}")
    end
  end
end
