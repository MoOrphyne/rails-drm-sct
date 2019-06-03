class Pack < ApplicationRecord
  has_many :user_pack, dependent: :destroy

  monetize :price_cents
  mount_uploader :photo, PhotoUploader

  validates :title, presence: true
  validates :photo, presence: true
  validates :price, presence: true
  validates :genre, presence: true

  GENRES = [
    'Hip Hop',
    '808',
    'Boom Bap'
  ]

  validates :genre, inclusion: { in: GENRES }

  def new?
    ((Time.zone.now - self.created_at) / 86400) < 3
  end
end
