class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname,                presence: true
  validates :encrypted_password,      presence: true, length: { minimum: 6 }
  validates :last_name,               presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :first_name,              presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :last_name_kana,          presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana,         presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :birthday,                presence: true, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }

  validate :password_complexity
  validate :email_complexity

  def password_complexity
    return if password.blank? || password =~ /(?=.*?[a-z])(?=.*?[0-9])/
    errors.add :password, 'Complexity requirement not met. Please use: half-width characters'
  end

  def email_complexity
    return if email.blank? || email =~ /(?=.*?[@])/
    errors.add :email, 'Complexity requirement not met. Please use: @ characters'
  end
end
