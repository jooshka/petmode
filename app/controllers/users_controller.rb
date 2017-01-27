class UsersController < ApplicationController
  before_action :set_user, only: [:show, :like, :unlike]
  before_action :set_current_user, only: [:edit, :update, :followers]

  # GET /users/1
  # GET /users/1.json
  def show
    @pets = @user.pets
  end

  def edit
  end

  def followers
    @users = current_user.followers
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
          :patronymic,
          :breeder,
          :about,
          :avatar
        )
    end
end
