# frozen_string_literal: true

require 'test_helper'

class Patients::IndexPatientsTest < ActionController::TestCase
  test '#call returns list of patients' do
    patients_collection = mock
    patients_collection.expects(:length)
    PatientRepository.expects(:find_all).returns(patients_collection)

    result = Patients::IndexPatients.call

    assert result.success?
    assert_equal patients_collection, result.patients
  end

  test '#call returns context.fail! is no patients are available' do
    PatientRepository.expects(:find_all).returns(nil)

    result = Patients::IndexPatients.call

    assert !result.success?
  end
end
