class AddAboutToPets < ActiveRecord::Migration[5.0]
  def change
    add_column :pets, :about, :text
  end
end
