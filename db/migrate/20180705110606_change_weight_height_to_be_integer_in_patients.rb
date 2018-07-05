class ChangeWeightHeightToBeIntegerInPatients < ActiveRecord::Migration[5.2]
  def change
    change_column(:patients, :weight, :integer)
    change_column(:patients, :height, :integer)
  end
end
