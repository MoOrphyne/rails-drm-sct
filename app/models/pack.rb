class Pack < ApplicationRecord
  has_many :user_pack, dependent: :destroy

  monetize :price_cents
  mount_uploader :photo, PhotoUploader

  validates :title, presence: true
  validates :photo, presence: true
  validates :price, presence: true

  def new?
    ((Time.zone.now - self.created_at) / 86400) < 31
  end
end
