class HomeController < ApplicationController
  def index
    @pets_sale = Pet.sale.limit(6)
    @pets_copulation = Pet.copulation.limit(3)
  end
end
