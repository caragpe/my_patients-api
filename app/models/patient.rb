# frozen_string_literal: true

class Patient < ApplicationRecord
  has_many :encounters, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :mrn, presence: true, uniqueness: true
end
