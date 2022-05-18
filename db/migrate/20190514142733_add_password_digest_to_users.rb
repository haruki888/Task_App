class AddPasswordDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_digest, :string
  end
end
#$ rails g migration add_password_digest_to_users password_digest:string ユーザーモデルにpassword_digestカラムを含める。
# to_usersを付けることで自動的にusersテーブルにカラムを追加するマイグレーションが生成され、手間が省ける。