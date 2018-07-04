class Encounter < ApplicationRecord
  belongs_to :patient

  validates :visit_number, :presence => true, :uniqueness => true
  validates :admitted_at, :presence => true
  validates :patient_id, :presence => true
end
