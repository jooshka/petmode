class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :settings, :update, :destroy, :advert, :advert_destroy]
  before_action :set_user, only: [:new, :edit, :create]

  # GET /pets/1
  # GET /pets/1.json
  def show
    @menu_tpl = 'menu'
    respond_to do |format|
      format.html do
        @card_sections = {
          sidebar: [
            { mod: 'ava', title: nil, tpl: 'avatar', options: { resource: @pet }  },
            { mod: 'bnr', title: nil, tpl: 'banner', options: {}  }
          ],
          body:    [
            { mod: 'ttl', title: nil, tpl: 'pets/info_title', options: { resource: @pet } },
            { mod: 'ttt', title: nil, tpl: 'pets/info_text', options: { resource: @pet } },
            { mod: 'abt', title: 'About me', tpl: 'about', options: { resource: @pet } }
          #  { mod: '', title: 'My pedigree',  tpl: 'bcards', options: { resource: @user.pets, size: 'md'}  },
          #  { mod: '', title: 'My dignities', tpl: 'bcards', options: { resource: @user.pets, size: 'lg'}  },
          #  { mod: '', title: 'My awards', tpl: 'bcards', options: { resource: @user.pets, size: 'lg'}  },
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
    @pet.build_birthday

    @resource = @pet
    @card_sections = {
      sidebar: [
        { mod: 'ava', title: nil, tpl: 'f_avatar', options: {}  },
        { mod: 'prt', title: 'Parents', tpl: 'bcards', options: { resource: @user.favorites, size: 'sm' }  },
        { mod: 'bnr', title: nil, tpl: 'banner', options: {}  }
      ],
      body:    [
        { mod: 'fmn', title: 'Main data', tpl: 'f_main', options: {}  },
        { mod: 'fst', title: nil, tpl: 'f_submit', options: {}  }
      ]
    }
    render 'f_card'
  end

  # GET /pets/1/edit
  def edit
    if @pet.lock?
      redirect_to @pet, notice: 'Advert locked card.'
      return
    end
    @menu_tpl = 'menu'
    @resource = @pet
    @card_sections = {
      sidebar: [
        { mod: 'ava', title: nil, tpl: 'f_avatar', options: {}  },
        { mod: 'bnr', title: nil, tpl: 'banner', options: {}  }
      ],
      body: [
        { mod: 'fmn', title: 'Main data', tpl: 'f_main', options: {}  },
        { mod: 'fst', title: nil, tpl: 'f_submit', options: {}  }
      ]
    }
    render 'f_card'
  end

  def advert
    @menu_tpl = 'menu'
    @resource = @pet
    @card_sections = {
      sidebar: [
        { mod: 'ava', title: nil, tpl: 'avatar', options: { resource: @pet } },
        { mod: 'bnr', title: nil, tpl: 'banner', options: {}  }
      ],
      body: [
      ]
    }
    if !@pet.advert || @pet.advert.editing?
      @pet.build_advert unless @pet.advert
      @pet.advert.user = current_user
      @pet.advert.status = 'moderation'
      @pet.advert.advert_type = 'sale'
      @card_sections[:body].push ({ mod: 'fad', title: 'Advert', tpl: 'f_advert', options: {} })
      @card_sections[:body].push ({ mod: 'fst', title: nil, tpl: 'f_submit', options: {}  })
    else
      @card_sections[:body].push ({ mod: 'fad', title: 'Advert', tpl: 'advert', options: {} })
    end
    render 'f_card'
  end

  def advert_destroy
    @pet.advert.destroy
    respond_to do |format|
      format.html { redirect_to @pet, notice: 'Advert was successfully destroyed.' }
      format.json { head :no_content }
    end
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

    def set_user
      @user = current_user
    end

    def pet_params
      params.fetch(:pet).permit(:user_id, :avatar, :name, :home_name, :gender, :family, :weight,
         birthday_attributes: [ :day, :month, :year  ],
         advert_attributes:   [ :advert_type, :price, :status, :user_id ]
      )
    end
end
