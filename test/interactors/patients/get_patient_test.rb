# frozen_string_literal: true

require 'test_helper'

class Patients::GetPatientTest < ActionController::TestCase
  test '#call retrieves a patient in particular by mrn' do
    patient = mock
    PatientRepository.expects(:find_by_mrn).returns(patient)

    result = Patients::GetPatient.call(patient_mrn: '1_000')

    assert result.success?
    assert_equal patient, result.patient
  end

  test '#call fails if the submitted parameter is not patient_mrn' do
    ERROR_PARAMS = "Following params are missing patient_mrn".freeze

    result = Patients::GetPatient.call(mrn: '1_000')

    assert !result.success?
    assert_equal ERROR_PARAMS, result.message
  end

  test '#call fails if patient_mrn does not exist' do
    NO_PATIENT_MRN_ERROR = "There is no patient with MRN 1_000".freeze
    patient = mock
    PatientRepository.expects(:find_by_mrn).returns(nil)

    result = Patients::GetPatient.call(patient_mrn: '1_000')

    assert !result.success?
    assert_equal NO_PATIENT_MRN_ERROR, result.message
  end
end
