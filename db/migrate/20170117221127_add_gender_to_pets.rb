class AddGenderToPets < ActiveRecord::Migration[5.0]
  def change
    add_reference :pets, :gender, foreign_key: true
  end
end
