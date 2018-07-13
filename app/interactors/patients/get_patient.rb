# frozen_string_literal: true

class Patients::GetPatient < BaseInteractor
  REQUIRED_PARAMS = %w[patient_mrn].freeze

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    context.patient_mrn = patient_mrn

    if patient = PatientRepository.find_by_mrn(context.patient_mrn)
      context.patient = patient
    else
      context.fail!(message: "There is no patient with MRN #{patient_mrn}")
    end
  end
end
