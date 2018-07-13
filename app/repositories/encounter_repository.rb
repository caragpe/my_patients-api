# frozen_string_literal: true

class EncounterRepository < BaseRepository
  class << self
    def find_by_visit_number(visit_number)
      klass.where('lower(visit_number) = ?', visit_number.downcase).first
    end

    def find_by_patient_id(patient_id)
      klass.where('patient_id = ?', patient_id)
    end

    def find_by_location(location)
      klass.where('lower(location) = ?', location.downcase)
    end

    def find_by_id!(id)
      klass.find(id)
    end

    private

    def klass
      Encounter
    end
  end
end
