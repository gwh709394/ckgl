class UsersController < ApplicationController
  before_action :set_user, only: [:reset_password, :edit, :update]
  def index
    @users = User.normal.page(params[:page])
    if params[:search]
      @users = @users.query (params[:search].to_s)
    end
  end
  
  def new
    @user = User.new
  end
  
  def reset_password
    @user.update_attributes(password: User::DEFAULTPWD, password_confirmation: User::DEFAULTPWD)
    redirect_to users_url, flash: {success: '操作成功.' }
  end
  
  def create
    default_code = 'ckgl888'
    @user = User.new(user_params)
    if @user.password.present? && @user.password != default_code
      @user.password_confirmation = @user.password
    else
      @user.password = @user.password_confirmation = default_code
    end
    
    respond_to do |format|
      if @user.check_user >=5 && current_user.name != 'administrator'
        format.html { redirect_to users_url, flash: {success: '操作失败.请联系管理员' }}
      else
        if @user.save
          format.html { redirect_to users_url, flash: {success: '操作成功.' }}
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  
  def edit
    if current_user.id != @user.id
      redirect_to root_url
    end
  end
  
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_user_url(@user), flash: {success: '操作成功.' } }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to edit_user_url(@user), flash: {success: '操作成功.' }
    else
      render "edit"
    end
  end
  
  private
  
    def set_user
      @user = User.find_by(id: params[:id])
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
    end
end
