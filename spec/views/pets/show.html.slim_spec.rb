require 'rails_helper'

RSpec.describe "pets/show", type: :view do
  before(:each) do
    @pet = assign(:pet, Pet.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
