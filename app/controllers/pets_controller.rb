class PetsController < ApplicationController
  helper_method :params
  before_action :set_pet, only: [:show, :edit, :settings, :update, :destroy, :advert, :advert_destroy]
  before_action :set_user, only: [:new, :edit, :create, :destroy]

  has_scope :by_family
  has_scope :by_gender
  has_scope :by_city
  has_scope :by_region
  has_scope :by_price, :using => [:started_at, :ended_at], :type => :hash

  def sale
    @resource = apply_scopes(Pet).sale
    render 'adverts'
  end

  def goodhands
    @resource = apply_scopes(Pet).goodhands
    render 'adverts'
  end

  def copulation
    @resource = apply_scopes(Pet).copulation
    render 'adverts'
  end

  # GET /pets/1
  # GET /pets/1.json
  def show
    @resource = @pet
    @menu_tpl = 'menu'
    respond_to do |format|
      format.html do
        @card_sections = {
          sidebar: [
            { tpl: 'avatar' },
            { tpl: 'banner' }
          ],
          body:    [
            { tpl: 'pets/info_title' },
            { tpl: 'pets/locality' },
            { tpl: 'pets/info_text' },
            { tpl: 'pets/advert_brief' },
            { tpl: 'about', title: 'About me' }
          #  { title: 'My pedigree',  tpl: 'bcards', opt: { resource: @user.pets, size: 'md'}  },
          #  { title: 'My dignities', tpl: 'bcards', opt: { resource: @user.pets, size: 'lg'}  },
          #  { title: 'My awards', tpl: 'bcards', opt: { resource: @user.pets, size: 'lg'}  },
          ]
        }
        render 'card'
      end
      format.json { render :show }
    end
  end

  # GET /pets/new
  def new
    @menu_tpl = 'users/menu'
    @pet = Pet.new
    @pet.family = 'cat'
    @pet.gender = 'male'
    @pet.build_avatar
    @pet.build_birthday
    @pet.user = current_user
    @resource = @pet
    @card_sections = {
      sidebar: [
        { tpl: 'f_avatar'  },
        { tpl: 'banner' }
      ],
      body:    [
        { tpl: 'f_main', title: 'Main data' },
        { tpl: 'f_submit' }
      ]
    }
    render 'f_card'
  end

  # GET /pets/1/edit
  def edit
    if @pet.lock?
      redirect_to @pet, alert: I18n.t('Advert locking card')
      return
    end
    @menu_tpl = 'menu'
    @resource = @pet
    @card_sections = {
      sidebar: [
        { tpl: 'f_avatar' },
        { tpl: 'banner'   }
      ],
      body: [
        { title: 'Main data', tpl: 'f_main' },
        { tpl: 'pets/f_edit_actions'  }
      ]
    }
    render 'f_card'
  end

  def advert
    @menu_tpl = 'menu'
    @resource = @pet
    @card_sections = {
      sidebar: [
        { tpl: 'avatar' },
        { tpl: 'banner' }
      ],
      body: []
    }
    if !@pet.advert || @pet.advert.editing?
      @pet.build_advert unless @pet.advert
      @pet.advert.user = current_user
      @pet.advert.status = 'moderation'
      @pet.advert.advert_type = 'sale'
      @card_sections[:body].push ({ tpl: 'f_advert', title: 'Advert' })
      @card_sections[:body].push ({ tpl: 'f_submit' })
    else
      @card_sections[:body].push ({ tpl: 'advert', title: 'Advert' })
    end
    render 'f_card'
  end

  def advert_destroy
    @pet.advert.destroy
    respond_to do |format|
      format.html { redirect_to @pet, notice: I18n.t('Advert was successfully destroyed') }
      format.json { head :no_content }
    end
  end

  # POST /pets
  # POST /pets.json
  def create
    @pet = Pet.new(pet_params)
    respond_to do |format|
      if @pet.save
        format.html { redirect_to @pet, notice: I18n.t('Pet card was successfully created') }
        format.json { render :show, status: :created, location: @pet }
      else
        format.html { render :new }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pets/1
  # PATCH/PUT /pets/1.json
  def update
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to @pet, notice: I18n.t('Pet card was successfully updated') }
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
      format.html { redirect_to @user, notice: I18n.t('Pet card was successfully destroyed') }
      format.json { head :no_content }
    end
  end

  private
    def set_pet
      @pet = Pet.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    def pet_params
      params.require(:pet).permit(
        :user_id, :name, :home_name,
        :gender, :family, :weight, :about,
        birthday_attributes: [ :id, :day, :month, :year  ],
        advert_attributes:   [ :id, :advert_type, :price, :status, :user_id ],
        avatar_attributes:   [ :id, :img ]
      )
    end
end
