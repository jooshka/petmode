class RmAvatarFromUsers < ActiveRecord::Migration[5.0]
  def up
    remove_attachment :users, :avatar
  end

  def down
    add_attachment :users, :avatar
  end
end
