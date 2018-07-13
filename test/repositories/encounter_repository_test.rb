# frozen_string_literal: true

require 'test_helper'

class EncounterRepositoryTest < ActiveSupport::TestCase
  ENCOUNTERS_PER_PATIENT = 3
  LOCATION = 'ELC'.freeze

  def setup
    @patient_with_encounters = create(:patient_with_encounters, encounters_count: ENCOUNTERS_PER_PATIENT)
    @encounters = @patient_with_encounters.encounters
  end

  test '#find_all encounters' do
    encounters = EncounterRepository.find_all

    assert_equal ENCOUNTERS_PER_PATIENT, encounters.count
  end

  test '#find_by_id returns successfully finds encounter if they exist' do
    encounter = EncounterRepository.find_by_id(@encounters.first.id)

    assert encounter
    assert_equal encounter, @encounters.first
  end

  test '#find_by_id returns nil is encounter does not exist' do
    encounter = EncounterRepository.find_by_id(999)

    assert_nil encounter
  end

  test '#find_by_id! successfully finds encounter if they exist' do
    encounter = EncounterRepository.find_by_id!(@encounters.first.id)

    assert encounter
    assert_equal encounter, @encounters.first
  end

  test '#find_by_id! raises exception if patient does not exist' do
    assert_raise(ActiveRecord::RecordNotFound) do
      EncounterRepository.find_by_id!(999)
    end
  end

  test '#find_by_visit_number finds encounter if they exists' do
    encounter = EncounterRepository.find_by_visit_number(@encounters.first.visit_number)

    assert encounter
    assert_equal encounter, @encounters.first
  end

  test '#find_by_visit_number returns nil if encounter does not exist' do
    encounter = EncounterRepository.find_by_visit_number('1234AABB')

    assert_nil encounter
  end

  test '#find_by_visit_number successfully finds encounter if they exist' do
    encounter = @encounters.first
    found_encounter = EncounterRepository.find_by_visit_number(encounter.visit_number)

    assert found_encounter
    assert_equal found_encounter, encounter
  end

  test '#find_by_patient_id successfully finds encounter if they exist' do
    patient_id = @patient_with_encounters.id
    found_encounters = EncounterRepository.find_by_patient_id(patient_id)

    assert found_encounters
    assert_equal ENCOUNTERS_PER_PATIENT, found_encounters.count
  end

  test '#find_by_patient_id returns nil if encounter does not exist' do
    patient_id = 999
    found_encounters = EncounterRepository.find_by_patient_id(patient_id)

    assert_empty found_encounters
  end

  test '#find_by_location successfully finds encounter with LOCATION location' do
    @patient_bob = create(:patient)
    @patient_alice = create(:patient)
    ENCOUNTERS_PER_PATIENT.times { create(:encounter, patient_id: @patient_bob.id, location: LOCATION) }
    ENCOUNTERS_PER_PATIENT.times { create(:encounter, patient_id: @patient_alice.id, location: LOCATION) }

    found_encounters = EncounterRepository.find_by_location(LOCATION)

    assert found_encounters
    assert_equal 2*ENCOUNTERS_PER_PATIENT, found_encounters.count
  end

  test '#find_by_location returns nil if LOCATION location does not exist' do
    found_encounters = EncounterRepository.find_by_location(LOCATION)

    assert_empty found_encounters
  end

  test '#destroy removes encounter but keeps patient' do
    encounters = EncounterRepository.find_by_patient_id(@patient_with_encounters.id)
    assert_equal ENCOUNTERS_PER_PATIENT, encounters.count

    encounter_to_remove = encounters.first

    EncounterRepository.destroy(encounter_to_remove)
    new_encounters = EncounterRepository.find_by_patient_id(@patient_with_encounters.id)

    assert_equal ENCOUNTERS_PER_PATIENT - 1, new_encounters.count
    assert @patient_with_encounters
  end

  test '#create fails if visit_number exists' do
    visit_number = @patient_with_encounters.encounters.first.visit_number

    encounter_params = {
      visit_number: visit_number,
      patient_id: @patient_with_encounters.id
    }

    encounter = EncounterRepository.create(encounter_params)

    refute encounter.valid?
    refute_empty encounter.errors.messages[:visit_number]
  end

  test '#update encounter with valid params is successful' do
    new_location = 'TORONTO'
    encounter = @patient_with_encounters.encounters.first
    refute_equal new_location, encounter.location

    encounter_params = { location: new_location }
    EncounterRepository.update(encounter, encounter_params)

    assert encounter.valid?
    assert_equal new_location, encounter.location
  end

  test '#update encounter with nil patient_id fails' do
    new_patient_id = nil
    encounter = @patient_with_encounters.encounters.first

    encounter_params = { patient_id: new_patient_id }
    EncounterRepository.update(encounter, encounter_params)

    refute encounter.valid?
    assert_equal 2, encounter.errors.count
  end

  test '#update encounter with non-existant patient_id fails' do
    new_patient_id = 999
    encounter = @patient_with_encounters.encounters.first

    encounter_params = { patient_id: new_patient_id }
    EncounterRepository.update(encounter, encounter_params)

    refute encounter.valid?
    assert_equal 1, encounter.errors.count
  end
end
