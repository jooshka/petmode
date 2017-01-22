class CreatePetBirthdays < ActiveRecord::Migration[5.0]
  def change
    create_table :pet_birthdays do |t|
      t.references :pet, unique: true, foreign_key: true
      t.integer :day
      t.integer :month
      t.integer :year

      t.timestamps
    end
  end
end
