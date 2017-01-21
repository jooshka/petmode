class Pet < ApplicationRecord
  has_attached_file :avatar, styles: { avatar: "219x200>", thumb: "120x120>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  belongs_to :user
  belongs_to :gender

  def display_name
    name.empty? ? "№#{id}" : name
  end

  before_validation do |pet|
    pet.name.try(:strip!)
  end

end
