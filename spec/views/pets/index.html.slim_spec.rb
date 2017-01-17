require 'rails_helper'

RSpec.describe "pets/index", type: :view do
  before(:each) do
    assign(:pets, [
      Pet.create!(),
      Pet.create!()
    ])
  end

  it "renders a list of pets" do
    render
  end
end
