class Encounter < ApplicationRecord
  belongs_to :patient, foreign_key: :patient_id

  validates :visit_number, presence: true, uniqueness: true
  validates :patient_id, presence: true

end
