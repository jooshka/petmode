class ChangeWeightTypeInPets < ActiveRecord::Migration[5.0]
  def self.up
    change_column :pets, :weight, :integer
  end

  def self.down
    change_column :pets, :weight, :decimal, precision: 8, scale: 3
  end
end
