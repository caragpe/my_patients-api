# frozen_string_literal: true

require 'test_helper'

class PatientRepositoryTest < ActiveSupport::TestCase
  NUMBER_OF_TEST_PATIENTS = 2
  ENCOUNTERS_PER_PATIENT = 3

  def setup
    @patient = create(:patient)
    @patient_with_encounters = create(:patient_with_encounters, encounters_count: ENCOUNTERS_PER_PATIENT)
  end

  test '#all_patients returns the correct amount of patients' do
    patients = PatientRepository.all_patients

    assert_includes patients, @patient
    assert_includes patients, @patient_with_encounters
    assert_equal NUMBER_OF_TEST_PATIENTS, patients.count
  end

  test '#find_all returns the correct amount of patients' do
    patients = PatientRepository.find_all

    assert_includes patients, @patient
    assert_includes patients, @patient_with_encounters
    assert_equal NUMBER_OF_TEST_PATIENTS, patients.count
  end

  test '#find_by_id successfully finds patient if they exist' do
    patient = PatientRepository.find_by_id(@patient.id)

    assert patient
    assert_equal @patient, patient
  end

  test '#find_by_id returns nil if patient does not exist' do
    patient = PatientRepository.find_by_id(999)

    assert_nil patient
  end

  test '#find_by_id! successfully finds patient if they exist' do
    patient = PatientRepository.find_by_id!(@patient.id)

    assert patient
    assert_equal @patient, patient
  end

  test '#find_by_id! raises exception if patient does not exist' do
    assert_raises(ActiveRecord::RecordNotFound) do
      PatientRepository.find_by_id!(999)
    end
  end

  test '#find_by_mrn successfully finds patient if they exist' do
    patient = PatientRepository.find_by_mrn(@patient.mrn)

    assert patient
    assert_equal @patient, patient
  end

  test '#find_by_mrn successfully finds patient with case sensitive mrn' do
    case_sensitive_mrn = @patient.mrn.upcase
    patient = PatientRepository.find_by_mrn(case_sensitive_mrn)

    assert patient
    assert_equal @patient, patient
  end

  test '#find_by_mrn returns nil if patient does not exist' do
    patient = PatientRepository.find_by_mrn('123456A')

    assert_nil patient
  end

  test '#find_by_first_name successfully finds patient if they exist' do
    patient_first_name = @patient.first_name
    found_patient = PatientRepository.find_by_first_name(patient_first_name)

    assert found_patient
    assert_equal @patient, found_patient
  end

  test '#find_by_first_name returns nil if patient does not exist' do
    patient = PatientRepository.find_by_first_name('FAKE_FIRST_NAME')

    assert_nil patient
  end

  test '#find_by_last_name successfully finds patient if they exist' do
    patient_last_name = @patient.last_name
    found_patient = PatientRepository.find_by_last_name(patient_last_name)

    assert found_patient
    assert_equal @patient, found_patient
  end

  test '#find_by_last_name returns nil if patient does not exist' do
    patient = PatientRepository.find_by_last_name('FAKE_LAST_NAME')

    assert_nil patient
  end

  test '#destroy removes patient and all encounters if successful' do
    encounters_count = @patient_with_encounters.encounters.length

    assert_equal ENCOUNTERS_PER_PATIENT, encounters_count

    found_patient = PatientRepository.destroy(@patient_with_encounters)
    refute Patient.exists?(found_patient.id)

    new_encounters_count = @patient_with_encounters.encounters.length
    assert_equal 0, new_encounters_count
  end

  test '#create fails if mrn already exists' do
    create(:patient, mrn: '111111A')

    patient_params = {
      first_name: 'first_name',
      last_name: 'last_name',
      mrn: '111111A'
    }

    patient = PatientRepository.create(patient_params)

    refute patient.valid?
    refute_empty patient.errors.messages[:mrn]
  end

  test '#update patient with valid params is successful' do
    new_name = 'New name'
    refute_equal @patient.first_name, new_name

    patient_params = { first_name: new_name }
    PatientRepository.update(@patient, patient_params)

    assert @patient.valid?
    assert_equal new_name, @patient.reload.first_name
  end

  test '#update patient with invalid first name fails' do
    new_first_name = ''

    patient_params = { first_name: new_first_name }
    PatientRepository.update(@patient, patient_params)

    refute @patient.valid?
    assert_equal 1, @patient.errors.count
  end

  test '#update patient with invalid last name fails' do
    new_last_name = ''

    patient_params = { last_name: new_last_name }
    PatientRepository.update(@patient, patient_params)

    refute @patient.valid?
    assert_equal 1, @patient.errors.count
  end
end
