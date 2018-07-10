# frozen_string_literal: true

class Patients::IndexPatients < BaseInteractor
  include Interactor

  def call
    if patients = PatientRepository.all_patients
      context.patients = patients
      context.length = patients.length
    else
      context.fail!(message: "No patients available")
    end
  end

end
