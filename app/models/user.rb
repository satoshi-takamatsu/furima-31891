class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  
  with_options presence: true do
    validates :nickname
    validates :email, uniqueness: { case_sensitive: false },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :encrypted_password, length: { minimum: 6 }
    validates :birthday, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }

    with_options format: { with: /\A[ぁ-んァ-ン一-龥々]/ } do #記憶の定着の為に記述 「々」の記述がないと、「々」が使用された時にエラーになってしまう
      validates :last_name
      validates :first_name
    end

    with_options format: { with: /\A[ァ-ヶー－]+\z/ } do
      validates :last_name_kana
      validates :first_name_kana
    end
  end

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
