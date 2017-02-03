class AddDefaultValueToFamilyToPets < ActiveRecord::Migration[5.0]
  def change
    change_column_default :pets, :family, 0
  end
end
