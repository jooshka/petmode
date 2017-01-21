class AddPetTypeToPets < ActiveRecord::Migration[5.0]
  def change
    add_reference :pets, :pet_type, foreign_key: true
  end
end
