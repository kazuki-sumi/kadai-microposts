class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.all.page(params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    # @userに空のModelオブジェクトを作成し、インスタンス変数@userに設定
    # @userはviewでも使える
    # controllerでrenderやredirect_toなどで明示的にレンダリングするviewをしていない場合は
    # メソッド名のviewファイルがレンダリングされる（例：new => new.html.erb）
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        flash[:success] = 'ユーザを登録しました。'
        redirect_to @user
      else
        flash.now[:danger] = 'ユーザの登録に失敗しました。'
        render :new
      end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
