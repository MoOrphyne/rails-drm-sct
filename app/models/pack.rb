class Pack < ApplicationRecord
  has_many :user_pack, dependent: :destroy
  mount_uploader :photo, PhotoUploader

  validates :title, presence: true
  validates :photo, presence: true
end
