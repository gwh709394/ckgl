class UsersController < ApplicationController
  before_action :set_user, only: [:reset_password]
  def index
    @users = User.all.page(params[:page])
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
  
  private
  
    def set_user
      @user = User.find_by(id: params[:id])
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
