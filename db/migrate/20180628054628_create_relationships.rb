class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      #foreign_keyで、どのカラム(列)の値が一致するレコード(行)を取得するか指定
      #今回の場合followテーブルは存在しないため、参照するべきテーブルを外部キーとして指定する
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: {to_table: :users}

      t.timestamps
      
      
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
