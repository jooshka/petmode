class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :settings, :update, :destroy, :like, :unlike]

  # GET /users/1
  # GET /users/1.json
  def show
    @pets = @user.pets
    render layout: 'application_card'
  end

  def settings
    render layout: 'current_user'
  end

  def followers
    @users = current_user.followers
    render :index, layout: 'current_user'
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

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
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
