require 'test_helper'

class Patients::IndexPatientsTest < ActionController::TestCase
  def setup
    patient_count = 2
    @patients_collection = create_list(:patient, patient_count)
  end

  # test '#call returns list of patients' do
  #   patients = mock
  #   PatientRepository.expects(:find_all).returns(patients)
  #   # patients_collection.expects(:length).returns(patient_count)
  #
  #   result = Patients::IndexPatients.call()
  #
  #   assert result.success?
  #   # binding.pry
  #   assert_equal patients, result.patients
  # end
  test '#call returns list of patients' do
    mock = MiniTest::Mock.new
    def mock.find_all; @patients_collection; end

    PatientRepository.stub :new, mock do
      result = Patients::IndexPatients.call()

      assert result.success?
      assert_equal @patients_collection, result.patients
    end
  end
end
