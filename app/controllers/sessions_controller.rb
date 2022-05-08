class SessionsController < ApplicationController
  protect_from_forgery with: :exception #CSRF対策(クロスサイトリクエストフォージェリ)
  include SessionsHelper #モジュール機能（一箇所にパッケージ化して使いまわせる）
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase) #ログインフォームから受け取ったemailの値を使ってユーザーオブジェクトを検索している
    if user && user.authenticate(params[:session][:password]) # &&は取得したユーザーオブジェクトが有効か判定する
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = '認証に失敗しました。'#flash nowはリダイレクトはしないがフラッシュは表示したい時に使える
      render:new
    end
  end
  
  
  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end
