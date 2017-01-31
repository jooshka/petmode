class UsersController < ApplicationController
  before_action :set_user, only: [:show, :like, :unlike]
  before_action :set_current_user, only: [:edit, :update, :followers]

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html do
        @card_sections = {
          sidebar: [
            { mod: 'ava', title: nil, tpl: 'avatar', options: { resource: @user } },
            { mod: 'fvt', title: 'Favorites', tpl: 'bcards', options: { resource: @user.favorites, size: 'sm' }  },
            { mod: 'bnr', title: nil, tpl: 'banner', options: {}  }
          ],
          body:    [
            { mod: 'ttl', title: nil, tpl: 'users/info_title', options: { resource: @user } },
            { mod: 'ttt', title: nil, tpl: 'users/info_text', options: { resource: @user } },
            { mod: 'abt', title: 'About me', tpl: 'about', options: { resource: @user } },
            { mod: 'pts', title: 'My pets',  tpl: 'bcards', options: { resource: @user.pets, size: 'md'}  },
            { mod: 'adw', title: 'My adverts', tpl: 'bcards', options: { resource: @user.pets, size: 'lg'}  },
            { mod: 'spc', title: 'My specialities', tpl: 'bcards', options: { resource: @user.pets, size: 'lg'}  },
          ]
        }
        render 'card'
      end
      format.json { render :show }
    end
  end

  def edit
    @card_sections = {
      sidebar: [
        { mod: 'ava', title: nil, tpl: 'avatar', options: { resource: @user }  },
        { mod: 'fvt', title: 'Favorites', tpl: 'bcards', options: { resource: @user.favorites, size: 'sm' }  },
        { mod: 'bnr', title: nil, tpl: 'banner', options: {}  }
      ],
      body:    [
        { mod: 'ttl', title: nil, tpl: 'users/info_title', options: { resource: @user } },
        { mod: 'edt', title: nil, tpl: 'form', options: { resource: @user } },
      ]
    }
    render 'card'
  end

  def followers
    respond_to do |format|
      format.html do
        @card_sections = {
          sidebar: [
            { mod: 'avt', title: nil, tpl: 'avatar', options: { resource: @user }  },
            { mod: 'fvr', title: 'Favorites', tpl: 'bcards', options: { resource: @user.favorites, size: 'sm' }  },
            { mod: 'bnr', title: nil, tpl: 'banner', options: {}  }
          ],
          body:    [
            { mod: 'flw', title: 'My followers', tpl: 'bcards', options: { resource: @user.followers, size: 'md' } },
          ]
        }
        render 'card'
      end
      format.json { render :followers }
    end
  end

  def like
    if @user && current_user.like(@user)
      redirect_to @user, notice: "#{@user.full_name} успешно добавлен(-а) в ваш список избранных."
    else
      redirect_to @user, notice: 'Этот пользователь уже есть у вас в контактах.'
    end
  end

  def unlike
    if @user && current_user.unlike(@user)
      redirect_to @user, notice: "#{@user.full_name} успешно удален(-а) из вашего списка избранных."
    else
      redirect_to @user, notice: 'Этого пользователя нет у вас в контактах.'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_current_user
      @user = current_user
    end

    def user_params
      params.fetch(:user, {})
        .permit(
          :last_name,
          :first_name,
          :breeder,
          :about,
          :avatar,
          :phone,
          :site,
          :city_id
        )
    end
end
