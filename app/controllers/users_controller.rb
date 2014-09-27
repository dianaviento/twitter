class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Обновление успешно"
      redirect_to @user
    else
      render 'edit'
    end
  end
    def show
      @user = User.find(params[:id])
      @microposts = @user.microposts.paginate(page: params[:page])
    end
  def create
   @user = User.new(user_params)    # Not the final implementation!
    if @user.save
        sign_in @user
      flash[:success] = "Добро пожаловать в Твиттер!"
      redirect_to @user
    else
      render 'new'
    end
    
  end
   def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
end
   def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
end


