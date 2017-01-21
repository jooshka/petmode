class DropPetWeights < ActiveRecord::Migration[5.0]
  def change
    drop_table :pet_weights
  end
end
