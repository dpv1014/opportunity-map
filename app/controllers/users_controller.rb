class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_paper_trail_whodunnit
  before_action :set_user, only: %i[ show edit update destroy ]

  add_breadcrumb "Usuarios", :users_path, except: :profile

  # GET /users
  def index
    @users = User.accessible_by(current_ability)
  end

  # GET /users/1
  def show
    add_breadcrumb "Ver usuario"
  end

  # GET /users/new
  def new
    add_breadcrumb "Crear usuario"
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    add_breadcrumb "Editar usuario"
  end

  def profile
    add_breadcrumb "Mi perfil"
    @user = current_user

  end

  # POST /users
  def create
    add_breadcrumb "Crear usuario"
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: "Usuario creado."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    add_breadcrumb "Editar usuario"
    new_params = user_params
    if params[:user][:password].blank?
      new_params.delete(:password)
      new_params.delete(:password_confirmation)
    end
    if @user.update(new_params)
      redirect_to @user, notice: "Usuario actualizado.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_profile
    add_breadcrumb "Mi perfil"
    new_params = user_params
    if params[:user][:password].blank?
      new_params.delete(:password)
      new_params.delete(:password_confirmation)
    end
    if current_user.update(new_params)
      redirect_to profile_users_path, notice: "Usuario actualizado.", status: :see_other
    else
      render :profile, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: "User eliminado.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.all.accessible_by(current_ability).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      unless current_user.admin?
        new_params = params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
        return new_params
      end

      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end
end
