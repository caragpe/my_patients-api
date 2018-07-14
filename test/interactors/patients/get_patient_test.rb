# frozen_string_literal: true

require 'test_helper'

class Patients::GetPatientTest < ActionController::TestCase
  test '#call retrieves a patient in particular by id' do
    patient = mock
    PatientRepository.expects(:find_by_id!).returns(patient)

    result = Patients::GetPatient.call(id: '1_000')

    assert result.success?
    assert_equal patient, result.patient
  end

  test '#call fails if the submitted parameter is not id' do
    ERROR_PARAMS = "Following params are missing id".freeze

    result = Patients::GetPatient.call(no_id: '1_000')

    refute result.success?
    assert_equal ERROR_PARAMS, result.message
  end

  test '#call fails if patient id does not exist' do
    NO_PATIENT_ID_ERROR = "There is no patient with ID 1000".freeze

    PatientRepository.expects(:find_by_id!).returns(nil)

    result = Patients::GetPatient.call(id: 1000)

    refute result.success?
    assert_equal NO_PATIENT_ID_ERROR, result.message
  end
end
