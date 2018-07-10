# frozen_string_literal: true

class PatientRepository < BaseRepository

  class << self
    def all_patients
      klass.all
    end

    def find_by_mrn(mrn)
      klass.where('lower(mrn) = ?', mrn.downcase).first
    end

    def find_by_first_name(first_name)
      klass.where('lower(first_name) = ?', first_name.downcase).first
    end

    def find_by_last_name(last_name)
      klass.where('lower(last_name) = ?', last_name.downcase).first
    end

    def find_by_id!(id)
      klass.find(id)
    end

    private

    def klass
      Patient
    end
  end
end
