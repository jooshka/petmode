class AddBreederToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :breeder, :boolean
  end
end
