class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    
    # 下記の記述でsessionhelper内のメソッドをコントローラ全体で使用できる
    include SessionsHelper
    
    private
    
    # ログイン状態の確認。ログインしていれば何もせず、ログインしていないと強制的にログインページへリダイレクトさせる。
    def require_user_logged_in
        unless logged_in?
            redirect_to login_url
        end
    end
    
    def counts(user)
        @count_microposts = user.microposts.count
        @count_followings = user.followings.count
        @count_followers = user.followers.count
        #@count_favarite = user.fav.count
    end
end
