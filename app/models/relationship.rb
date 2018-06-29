class Relationship < ApplicationRecord
  belongs_to :user
  #class_name 対象となるモデルを指定
  #class_name: 'User'と補足設定することでfollowがFollowという存在しないクラスを参照することを防ぎ、Userクラスであることを明示する
  belongs_to :follow, class_name: 'User'
  
  validates :user_id, presence: true
  validates :follow_id, presence: true
end
