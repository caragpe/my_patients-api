# frozen_string_literal: true

class Patients::IndexPatients < BaseInteractor

  def call
    if patients = PatientRepository.find_all
      context.patients = patients
      context.length = context.patients.length
    else
      context.fail!(message: "No patients available")
    end
  end

end
