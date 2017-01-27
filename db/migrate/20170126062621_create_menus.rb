class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string  :url, default: '#'
      t.string  :text
      t.string  :icon
      t.string  :class_name
      t.integer :kind
      t.integer :order_num
      t.boolean :visible, default: true

      t.timestamps
    end
  end
end
