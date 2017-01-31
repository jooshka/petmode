class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.references :region
      t.references :locality_type
      t.string :name_ru
      t.string :name_en

      t.timestamps
    end
  end
end
