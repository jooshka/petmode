class DropTablePetTypes < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key 'pets', 'pet_types'
    remove_index :pets, :pet_type_id
    remove_column :pets, :pet_type_id
    drop_table :pet_types
  end
end
