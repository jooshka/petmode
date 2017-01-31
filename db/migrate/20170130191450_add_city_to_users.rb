class AddCityToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :city
  end
end
