class CreateLocalityTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :locality_types do |t|
      t.string :name_en
      t.string :name_ru

      t.timestamps
    end
  end
end
