# frozen_string_literal: true

require 'test_helper'

class PatientRepositoryTest < ActiveSupport::TestCase
  ENCOUNTERS_PER_PATIENT = 3

  def setup
    @patient = create(:patient)
    @patient_with_encounters = create(:patient_with_encounters, encounters_count: ENCOUNTERS_PER_PATIENT)
  end

  # test 'Initial test' do
  #   puts @patient.inspect
  #   puts @patient_with_encounters.inspect
  #   @patient_with_encounters.encounters.each do |encounter|
  #     puts encounter.inspect
  #   end
  # end

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
    assert patient.errors[:mrn]
  end
  #
  # test '#update with valid params' do
  #   new_name = 'New Name'
  #   refute_equal @user.first_name, new_name
  #
  #   role = create(:role, site: @site, name: Role::ADMIN_ROLE_NAME)
  #   user_params = { first_name: new_name, role_ids: [role.id] }
  #
  #   PatientRepository.update(@user, user_params)
  #
  #   assert @user.valid?
  #   assert_equal new_name, @user.reload.first_name
  #   assert_includes @user.reload.role_ids, role.id
  # end
  #
  # test '#update with invalid params' do
  #   new_name = ''
  #   user_params = { first_name: new_name }
  #
  #   user = PatientRepository.update(@user, user_params)
  #
  #   refute user.valid?
  #   refute_equal new_name, user.reload.first_name
  # end
  #
  # test '#update user with already assigned role' do
  #   role = create(:role)
  #   @user.roles << role
  #
  #   assert_raises ActiveRecord::RecordInvalid do
  #     @user.roles << role
  #   end
  # end

end
