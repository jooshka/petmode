class AddHomeNameToPets < ActiveRecord::Migration[5.0]
  def change
    add_column :pets, :home_name, :string
  end
end
