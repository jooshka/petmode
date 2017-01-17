class PetForm
  include Virtus
  include ActiveModel::Model

  attr_reader :pet

  attribute :user_id, Integer
  attribute :name, String
  attribute :weight, Float

  validates :weight,
            allow_blank: true,
            numericality: { only_float: true, greater_than: 0.020 }

  def self.model_name
    ActiveModel::Name.new(self, nil, "Pet")
  end

  def persisted?
    @pet.persisted?
  end

  def id
    @pet.id
  end

  def initialize(attributes = {})
    if attributes[:id].nil?
      @pet = Pet.new
      assign_attributes(attributes)
    else
      @pet = Pet.find(attributes[:id])
      self.name = attributes[:name].nil? ? @pet.name : attributes[:name]
      self.weight = attributes[:weight].nil? ? @pet.last_weight : attributes[:weight]
      self.user_id = attributes[:user_id]
    end
  end

  def save
    begin
      if valid?
        persist!
        @pet
      else
        false
      end
    rescue ActiveRecord::RecordNotSaved => e
      errors.full_messages
    end
  end

  def update
    save
  end

private

  def new_record?
    @pet.new_record?
  end

  def persist!
    @pet.transaction do
      if @pet.new_record?
        @pet.update_attributes(user_id: user_id, name: name)
        @pet.save!
      elsif !(name.empty?) && @pet.name!=name
        @pet.update_attributes(name: name)
        @pet.save!
      end
      if !(weight.empty?) && @pet.last_weight!=weight
        @pet.weights.create!(user_id: user_id, date: Date.today, weight: weight)
      end
    end
  end

end
