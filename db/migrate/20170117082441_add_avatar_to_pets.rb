class AddAvatarToPets < ActiveRecord::Migration[5.0]
  def up
    add_attachment :pets, :avatar
  end

  def down
    remove_attachment :pets, :avatar
  end
end
