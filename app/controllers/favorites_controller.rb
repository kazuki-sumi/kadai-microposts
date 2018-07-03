class FavoritesController < ApplicationController
  # 各コントローラの全アクションで共通する処理がある場合before_actionを使う
  # 下記でログインしているか確認
  before_action :require_user_logged_in
  
  # micropostモデルから
  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.fav(micropost)
    flash[:success] = 'お気に入り登録しました。'
    # 一つ前のページにもどる
    # redirect_back(fallback_location: url)
    # url 直前のページがなかった場合のリンク先
    redirect_back(fallback_location: root_url)
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unfav(micropost)
    flash[:success] = 'お気に入り登録を解除しました。'
    redirect_back(fallback_location: root_url)
  end
end
