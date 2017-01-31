class CreateRegions < ActiveRecord::Migration[5.0]
  def change
    create_table :regions do |t|
      t.references :country
      t.references :locality_type
      t.string :name_ru
      t.string :name_en

      t.timestamps
    end
  end
end
