class DropForeignKeys < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key 'pets', 'users'
    remove_foreign_key 'pet_birthdays', 'pets'
  end
end
