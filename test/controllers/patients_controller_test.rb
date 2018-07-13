# frozen_string_literal: true
require 'test_helper'

class PatientsControllerTest < ActionController::TestCase
  def setup
    @patient_bob = create(:patient, first_name: 'Bob')
    @patient_alice = create(:patient, first_name: 'Alice')
    @patient_john = create(:patient_with_encounters, first_name: 'John')
  end

  test '#index retrieves successfully all patients' do
    patient_count = 5
    patients = build_stubbed_list(:patient, patient_count)

    interactor_result = mock

    Patients::IndexPatients.expects(:call).returns(interactor_result)
    interactor_result.expects(:patients).returns(patients)
    interactor_result.expects(:length).returns(patient_count)

    get :index

    assert_response :ok
    assert_equal patient_count, parsed_response['length']
  end

  test '#index returns no patients' do
  end
end
