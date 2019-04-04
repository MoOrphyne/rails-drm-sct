class User < ApplicationRecord
  has_many :user_pack, dependent: :destroy
  has_many :packs, through: :user_pack

  mount_uploader :photo, PhotoUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def to_subscriber
    self.subscriber = true
    Pack.last(3).each do |pack|
      UserPack.create(user_id: self.id, pack_id: pack.id)
    end
    self.save
  end
end
