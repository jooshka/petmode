class DropTableGenders < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key 'pets', 'genders'
    remove_index :pets, :gender_id
    remove_column :pets, :gender_id
    drop_table :genders
  end
end
