class UsersController < ApplicationController
  before_action :set_user, only: [:show, :like, :unlike]
  before_action :set_current_user, only: [:edit, :update, :followers]

  # GET /users/1
  # GET /users/1.json
  def show
    @resource = @user
    respond_to do |format|
      format.html do
        @menu_tpl = 'menu'
        @card_sections = {
          sidebar: [
            { tpl: 'avatar' },
            { tpl: 'bcards', opt: { resource: @user.favorites, size: 'sm' }, title: 'Favorites' },
            { tpl: 'banner' }
          ],
          body:    [
            { tpl: 'info_title' },
            { tpl: 'info_text'  },
            { tpl: 'card_share_actions'  },
            { tpl: 'about', title: 'About me' },
            { tpl: 'bcards', opt: { resource: @user.my_pets, size: 'md' }, title: 'My pets' },
            { tpl: 'bcards', opt: { resource: @user.pets_of_my_adverts, size: 'lg' }, title: 'My adverts' }
          #  { mod: 'spc', title: 'My specialities', tpl: 'bcards', options: { resource: @user.pets, size: 'lg'}  },
          ]
        }
        render 'card'
      end
      format.json { render :show }
    end
  end

  def edit
    @menu_tpl = 'menu'
    @resource = @user
    @card_sections = {
      sidebar: [
        { tpl: 'f_avatar' },
        { tpl: 'banner'   }
      ],
      body: [
        { tpl: 'f_main', title: 'Main data' },
        { tpl: 'f_subscribes', title: 'Subscriptions' },
        { tpl: 'f_submit' }
      ]
    }
    render 'f_card'
  end

  def followers
    @menu_tpl = 'menu'
    @resource = @user
    respond_to do |format|
      format.html do
        @card_sections = {
          sidebar: [
            { tpl: 'avatar' },
            { tpl: 'bcards', opt: { resource: @user.favorites, size: 'sm' }, title: 'Favorites' },
            { tpl: 'banner' }
          ],
          body:    [
            { tpl: 'bcards', opt: { resource: @user.followers, size: 'md' }, title: 'My followers' },
          ]
        }
        render 'card'
      end
      format.json { render :followers }
    end
  end

  def like
    if @user && current_user.like(@user)
      redirect_to @user, notice: "#{@user.display_name} успешно добавлен(-а) в ваш список избранных."
    else
      redirect_to @user, notice: 'Этот пользователь уже есть у вас в контактах.'
    end
  end

  def unlike
    if @user && current_user.unlike(@user)
      redirect_to @user, notice: "#{@user.display_name} успешно удален(-а) из вашего списка избранных."
    else
      redirect_to @user, notice: 'Этого пользователя нет у вас в контактах.'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: I18n.t('User card was successfully updated') }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to @user }
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
      params.require(:user).permit(
        :last_name, :first_name, :breeder, :about,
        :phone, :site, :city_id,
        avatar_attributes:   [ :img, :id ]
      )
    end
end
