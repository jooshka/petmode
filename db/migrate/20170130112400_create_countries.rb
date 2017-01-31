class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.string :name_ru
      t.string :name_en
      t.string :iso
      t.string :iso3
      t.string :iso_num

      t.timestamps
    end
  end
end
