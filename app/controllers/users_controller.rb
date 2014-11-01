class UsersController < ApplicationController
  # Set the '@user' variable when dealing with the #show, #edit, etc. actions.
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # Required a user to be logged in to go ahead with the #edit, #update, and
  # #destroy actions.
  before_action :logged_in_user, only: [:edit, :update, :destroy]

  # On top of being logged in, the user must be the *correct* user in order to
  # go through with the #edit, #update, and #destroy actions.
  before_action :correct_user, only: [:edit, :update]

  # Only admin users can destroy other users.
  before_action :admin_user, only: [:destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.order(:name)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
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

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end

    def logged_in_user
      if !logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      flash[:danger] = @user.name.to_s
      if !(current_user? @user)
        flash.now[:danger] = "Please log in as #{@user.name}."
        redirect_to root_url
      end
    end
end
