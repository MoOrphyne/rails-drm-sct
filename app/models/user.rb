class User < ApplicationRecord
  has_many :user_pack, dependent: :destroy
  has_many :packs, through: :user_pack
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
