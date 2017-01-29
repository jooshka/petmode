class CreateAdverts < ActiveRecord::Migration[5.0]
  def change
    create_table :adverts do |t|
      t.references :pet
      t.integer :advert_type
      t.decimal :price, precision: 10, scale: 2
      t.integer :status
      t.text :comment

      t.timestamps
    end
  end
end
