# frozen_string_literal: true

class PatientsController < ApplicationController
  def index
    result = ::Patients::IndexPatients.call
    length = result.length
    patients = result.patients

    render json: { patients: patients, length: length }, status: :ok
  end

  def show
    result = ::Patients::GetPatient.call(id: params[:id])
    if result.success?
      render json: { patient: result }, status: :ok
    else
      render json: { patient: nil }, status: :error
    end
  end
end
