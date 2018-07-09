class PatientsController < ApplicationController

  def index
    result = ::Patients::IndexPatients.call()
    length = result.length

    render json: { patients: result, length: length }, status: :ok
  end
end
