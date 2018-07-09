# frozen_string_literal: true

class Patients::IndexPatients < BaseInteractor

  def call
    context.patients = PatientRepository.find_all
    context.length = context.patients.length
  end

end
