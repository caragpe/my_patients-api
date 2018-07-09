class PatientsController < ApplicationController

  def index
    result = ::Patients::IndexPatients.call()
    length = result.length
    patients = result.patients

    render json: { patients: patients, length: length }, status: :ok
  end
end
