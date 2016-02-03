class User < ActiveRecord::Base

  has_many :reviews, dependent: :destroy

  has_secure_password

  validates :email, presence: true

  validates :firstname, presence: true

  validates :lastname, presence: true

  validates :password, length: { in: 6..20 }, on: :create

  def firstname_last_initial
    "#{firstname} #{lastname[0,1]}"
  end
end
