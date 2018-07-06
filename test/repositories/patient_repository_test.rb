# frozen_string_literal: true

require 'test_helper'

class PatientRepositoryTest < ActiveSupport::TestCase
  def setup
    @patient = create(:patient)
    @encounter = create(:encounter)
  end

  test 'Initial test' do
    puts @patient.inspect
    puts @encounter.inspect
  end
end
