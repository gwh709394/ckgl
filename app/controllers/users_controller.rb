class UsersController < ApplicationController
  
  def index
    @users = User.all.page(params[:page])
  end
  
  def new
    @user = User.new
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
      if @user.save
        format.html { redirect_to users_url, flash: {success: '操作成功.' }}
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
