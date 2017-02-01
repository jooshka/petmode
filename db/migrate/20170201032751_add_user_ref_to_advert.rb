class AddUserRefToAdvert < ActiveRecord::Migration[5.0]
  def change
    add_reference :adverts, :user
  end
end
