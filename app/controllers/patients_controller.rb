# frozen_string_literal: true

class PatientsController < ApplicationController
  def index
    result = ::Patients::IndexPatients.call
    length = result.length
    patients = result.patients

    render json: { patients: patients, length: length }, status: :ok
  end

  def show
    result = ::Patients::GetPatient.call(patient_mrn: params[:patient_mrn])
    if result.success?
      render json: { patient: "Success!"}, status: :ok
    else
      render json: { patient: "No success :()"}, status: :errorrai
    end
  end
end
