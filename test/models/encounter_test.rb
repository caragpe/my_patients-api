# frozen_string_literal: true
require 'test_helper'

class EncounterTest < ActiveSupport::TestCase
  should belong_to(:patient)

  should validate_presence_of(:visit_number)
  should validate_presence_of(:patient_id)

  should validate_uniqueness_of(:visit_number)
end
