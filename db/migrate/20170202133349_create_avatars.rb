class CreateAvatars < ActiveRecord::Migration[5.0]
  def change
    create_table :avatars do |t|
      t.references :imageable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
