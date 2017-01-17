class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  # GET /pets
  # GET /pets.json
  def index
    @pets = Pet.all
  end

  # GET /pets/1
  # GET /pets/1.json
  def show
  end

  # GET /pets/new
  def new
    @pet_form = PetForm.new
    render layout: 'user'
  end

  # GET /pets/1/edit
  def edit
    @pet_form = PetForm.new(id: params[:id])
  end

  # POST /pets
  # POST /pets.json
  def create
    @pet_form = PetForm.new(pet_form_params)
    respond_to do |format|
      if @pet_form.save
        format.html { redirect_to @pet_form.pet, notice: 'Pet was successfully created.' }
        format.json { render :show, status: :created, location: @pet_form.pet }
      else
        format.html { render :new, layout: 'user' }
        format.json { render json: @pet_form.pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pets/1
  # PATCH/PUT /pets/1.json
  def update
    @pet_form = PetForm.new(pet_form_params.merge(id: params[:id]))
    respond_to do |format|
      if @pet_form.update
        format.html { redirect_to @pet, notice: 'Pet was successfully updated.' }
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pets/1
  # DELETE /pets/1.json
  def destroy
    @pet.destroy
    respond_to do |format|
      format.html { redirect_to pets_url, notice: 'Pet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_pet
      @pet = Pet.find(params[:id])
    end

    def pet_form_params
      params.fetch(:pet).permit(:name, :weight, :user_id)
    end
end
