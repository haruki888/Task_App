class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit 
  end
  
  def new
    @user = User.new
  end
   
  def login
    @user = User.find_by(email:params[:email],password:params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました。"
      redirect_to users_index_url
    else
      render :login_page
    end
  end 
  
  def logout 
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました。"
    redirect_to login_url
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
