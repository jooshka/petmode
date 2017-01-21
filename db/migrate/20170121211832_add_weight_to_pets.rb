class AddWeightToPets < ActiveRecord::Migration[5.0]
  def change
    add_column :pets, :weight, :decimal, precision: 8, scale: 3
  end
end
