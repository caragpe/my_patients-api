# frozen_string_literal: true

require 'test_helper'

class PatientsControllerTest < ActionController::TestCase
  # def setup
  #   @patient_bob = create(:patient, first_name: 'Bob')
  #   @patient_alice = create(:patient, first_name: 'Alice')
  #   @patient_john = create(:patient_with_encounters, first_name: 'John')
  # end

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
    patient = create(:patient)

    interactor_result = mock
    interactor_result.expects(:success?).returns(true)
    # interactor_result.expects(:length).returns(1)
    interactor_result.expects(:patient).returns(patient)

    Patients::GetPatient.expects(:call).returns(interactor_result)
binding.pry
    get :show, params: { id: patient.id }

    assert_response :ok
    assert_equal patient, parsed_response['body']
  end
end
