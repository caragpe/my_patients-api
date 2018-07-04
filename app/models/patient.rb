class Patient < ApplicationRecord
  has_many :encounters
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :mrn, :presence => true
end
