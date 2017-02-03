class AddImgToAvatars < ActiveRecord::Migration[5.0]
  def up
    add_attachment :avatars, :img
  end

  def down
    remove_attachment :avatars, :img
  end
end
