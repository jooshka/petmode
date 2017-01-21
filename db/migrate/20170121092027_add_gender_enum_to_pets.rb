class AddGenderEnumToPets < ActiveRecord::Migration[5.0]
  def change
    add_column :pets, :gender, :integer, default: 0
  end
end
