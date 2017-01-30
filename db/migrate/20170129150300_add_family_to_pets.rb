class AddFamilyToPets < ActiveRecord::Migration[5.0]
  def change
    add_column :pets, :family, :integer
  end
end
