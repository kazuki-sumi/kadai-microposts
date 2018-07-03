class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50}
    validates :email, presence: true, length: {maximum: 255},
                      format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false }
    has_secure_password
    
    # User ⇔　relationship  ⇔ User
    
    has_many :microposts 
    #UserがRelationshipと一対多である関係を示す
    has_many :relationships
    #user.followingsと書けば、userがフォローしているUser達を取得できる
    #through: :relationshipは、has_many: relationshipの結果を中間テーブルとして指定します
    #さらにその中間テーブルのカラムの中でどれを参照先のidとすべきかをsource: :followで選択する
    #結果として、user.followingsは、userが中間テーブルrelationshipsを取得し、その一つ一つのrelationshipのfollow_idから、「フォローしているUser達」を取得しています
    has_many :followings, through: :relationships, source: :follow
    #class_name: 'Relationship'で参照するクラスを指定
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user
    
    def follow(other_user)
        # user.follow(other)が実行されるとselfにuserが代入される
        unless self == other_user
            self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end
    
    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end
    
    def following?(other_user)
        self.followings.include?(other_user)
    end
    
    def feed_microposts
        # Micropost.where(user_id: フォローユーザ + 自分自身) となるものを全て取得
        Micropost.where(user_id: self.following_ids + [self.id])
    end
    
    # userモデルと中間テーブルのfavoriteモデルを一対多の関係にする
    # user.favoritesとするとFavorite達を取得できる
    has_many :favorites
    # 下記でuser.favorite_micropostsと書けば、お気に入りしている投稿のidであるmicropost_idを取得できる
    has_many :favorite_microposts, through: :favorites, source: :micropost
    
    # 
    def fav(micropost)
        self.favorites.find_or_create_by(micropost_id: micropost.id)
    end
    
    # お気に入りがあればお気に入りを解除する
    def unfav(micropost)
        favorite = self.favorites.find_by(micropost_id: micropost.id)
        favorite.destroy if favorite
    end
    
    # self.favorite_micropostsでお気に入りしているMicropostを取得
    # include?(micropost)によりお気に入りでないmicropostは含まれていないか確認
    def faving?(micropost)
        self.favorite_microposts.include?(micropost)
    end
end