# frozen_string_literal: true
require 'test_helper'

class PatientsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @patient_bob = create(:patient, first_name: 'Bob')
    @patient_alice = create(:patient, first_name: 'Alice')
    @patient_john = create(:patient_with_encounters, first_name: 'John')
  end
  
  test '#index retrieves all patients' do

  end
end
