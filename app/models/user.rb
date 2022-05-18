class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :tasks, dependent: :destroy
  before_save { self.email = email.downcase }#コールバックメソッド（before .save)でメールアドレスを小文字にする。self.email=email.downcase
  #selfはユーザーオブジェクトを指す
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i#メールアドレスの正規表現
  validates :name, presence: true, length: { maximum: 50 }  
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },#メールアドレスがフォーマットの形式に合うか検証する
                    uniqueness: #一意性の検証
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: 
  #1. ハッシュ化したパスワードを、データベースのpassword_digestというカラムに保存できるようになる。
  #2. ペアとなる仮想的なカラムであるpasswordとpassword_confirmationが使えるようになる。さらに存在性と値が一致するかどうかの検証も追加される。
  #3. authenticateメソッドが使用可能となる。このメソッドは引数の文字列がパスワードと一致した場合オブジェクトを返し、パスワードが一致しない場合はfalseを返す。

  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end  
end
