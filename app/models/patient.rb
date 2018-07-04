class Patient < ApplicationRecord
  has_many :encounters
end
