class RmAvatarFromPets < ActiveRecord::Migration[5.0]
  def up
    remove_attachment :pets, :avatar
  end

  def down
    add_attachment :pets, :avatar
  end
end
