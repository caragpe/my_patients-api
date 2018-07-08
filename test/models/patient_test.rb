# frozen_string_literal: true
require 'test_helper'

class PatientTest < ActiveSupport::TestCase
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:mrn)

  should validate_uniqueness_of(:mrn)

  should have_many(:encounters).dependent(:destroy)
end
