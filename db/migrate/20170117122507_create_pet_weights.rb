class CreatePetWeights < ActiveRecord::Migration[5.0]
  def change
    create_table :pet_weights do |t|
      t.references :user, foreign_key: true
      t.references :pet, foreign_key: true
      t.decimal :weight, precision: 8, scale: 3
      t.date :date

      t.timestamps
    end
  end
end
