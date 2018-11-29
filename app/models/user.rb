class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :restaurants
  has_many :claims

  # has_secure_token :access_token


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def name
    "#{email}"
  end
end
