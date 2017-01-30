class CreateRegions < ActiveRecord::Migration[5.0]
  def change
    create_table :regions do |t|
      t.references :country
      t.string :name

      t.timestamps
    end
  end
end
