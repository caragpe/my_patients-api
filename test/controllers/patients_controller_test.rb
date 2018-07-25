# frozen_string_literal: true

require 'test_helper'

class PatientsControllerTest < ActionController::TestCase
  test '#index retrieves successfully all patients' do
    patient_count = 5
    patients = build_stubbed_list(:patient, patient_count)

    interactor_result = mock
    interactor_result.expects(:patients).returns(patients)
    interactor_result.expects(:length).returns(patient_count)

    Patients::IndexPatients.expects(:call).returns(interactor_result)

    get :index

    assert_response :ok
    assert_equal patient_count, parsed_response['length']
  end

  test '#index returns empty patient collection if there are no patients' do
    no_patients_returned = mock
    no_patients_returned.expects(:length).returns(0)
    no_patients_returned.expects(:patients).returns([])

    Patients::IndexPatients.expects(:call).returns(no_patients_returned)

    get :index

    assert_response :ok
    assert_equal 0, parsed_response['length']
  end

  test '#show returns patient' do
    TIME_UP_TO_SECONDS = 18
    patient = create(:patient)

    interactor_result = mock
    interactor_result.expects(:success?).returns(true)
    interactor_result.expects(:patient).returns(patient)

    Patients::GetPatient.expects(:call).returns(interactor_result)

    get :show, params: { id: patient.id }

    assert_response :ok
    assert_equal patient.id, parsed_response['patient']['id']
    assert_equal patient.first_name, parsed_response['patient']['first_name']
    assert_equal patient.last_name, parsed_response['patient']['last_name']
    assert_equal patient.middle_name, parsed_response['patient']['middle_name']
    assert_equal patient.weight, parsed_response['patient']['weight']
    assert_equal patient.height, parsed_response['patient']['height']
    assert_equal patient.mrn, parsed_response['patient']['mrn']
    assert_equal patient.created_at.strftime("%Y-%m-%dT%H:%M:%S"), parsed_response['patient']['created_at'][0..TIME_UP_TO_SECONDS]
    assert_equal patient.updated_at.strftime("%Y-%m-%dT%H:%M:%S"), parsed_response['patient']['updated_at'][0..TIME_UP_TO_SECONDS]
  end
end
