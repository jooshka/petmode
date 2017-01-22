class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :settings, :update, :destroy, :control]

  # GET /pets/1
  # GET /pets/1.json
  def show
    render layout: 'application_card'
  end

  # GET /pets/new
  def new
    @pet = Pet.new
    @pet.pet_type_id = 1
    @pet.gender = 'male'
    @pet.build_birthday
    render layout: 'current_user'
  end

  # GET /pets/1/edit
  def edit
    render layout: 'application_card'
  end

  def control
    render layout: 'application_card'
  end

  # POST /pets
  # POST /pets.json
  def create
    @pet = Pet.new(pet_params)
    respond_to do |format|
      if @pet.save
        format.html { redirect_to @pet, notice: 'Pet was successfully created.' }
        format.json { render :show, status: :created, location: @pet }
      else
        format.html { render :new, layout: 'current_user' }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pets/1
  # PATCH/PUT /pets/1.json
  def update
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to @pet, notice: 'Pet was successfully updated.' }
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit, layout: 'application_card' }
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

    def pet_params
      params.fetch(:pet).permit(:name, :user_id, :gender, :pet_type_id, :weight,
         birthday_attributes: [:day, :month, :year])
    end
end
