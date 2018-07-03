class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 255}
  
  # micropostモデルと中間テーブルのfavoriteモデルを一対多の関係にする
  # has_many :テーブル名
  has_many :favorites
  # 下記でmicropost.favorite_usersとかけば、投稿をお気に入りしているユーザのidであるuser_idが取得できる
  # has_many :through 関連付けで関連名を規則外にした時は ｀source｀ の指定が必要です。
  # ｀source｀ 中間モデルの ｀belongs_to｀ の関連名と一致させる、と覚えておきましょう。
  has_many :favorite_users, through: :favorites, source: :user
end
