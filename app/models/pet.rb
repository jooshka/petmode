class Pet < ApplicationRecord
  has_attached_file :avatar, styles: { avatar: "219x200>", thumb: "120x120>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  belongs_to :user
  has_many :weights, class_name: 'PetWeight', dependent: :destroy

  validates :weight,
            allow_blank: true,
            numericality: { only_float: true, greater_than: 0.020 }

  def last_weight
    weights.empty? ? nil : weights.last.weight
  end

  def display_name
    name.empty? ? "№#{id}" : name
  end

  before_validation do |pet|
    pet.name.try(:strip!)
  end

end
