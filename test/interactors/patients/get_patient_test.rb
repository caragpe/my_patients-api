# frozen_string_literal: true

require 'test_helper'

class Patients::GetPatientTest < ActionController::TestCase
  test '#call retrieves a patient in particular by mrn' do
    patient = mock
    PatientRepository.expects(:find_by_mrn).returns(patient)

    result = Patients::GetPatient.call( patient_id: 1_000)

    assert result.success?
    assert_equal patient, result.patient
  end
end
