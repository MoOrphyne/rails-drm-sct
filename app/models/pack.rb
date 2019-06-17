class Pack < ApplicationRecord
  has_many :user_packs, dependent: :destroy
  has_many :order_items
  has_many :reviews

  monetize :price_cents

  mount_uploader :photo, PhotoUploader
  mount_uploader :file, FileUploader

  validates :title, presence: true
  validates :photo, presence: true
  validates :price, presence: true
  validates :genre, presence: true
  validates :file, presence: true
  validates :infos, presence: true

  GENRES = [
    'Hip Hop',
    '808',
    'Boom Bap',
    'Trap',
    'Vocals',
  ]

  INFOS = [
    '44.1khz',
    '48khz',
    '96khz',
    '16bits',
    '24bits',
    'Wav',
    'Aiff',
    'Mp3'
  ]

  validates :genre, inclusion: { in: GENRES }

  include PgSearch

  pg_search_scope :search_by_title_and_genre,
    against: [ :title, :genre ],
    using: {
      tsearch: { prefix: true }
    }

  def new?
    ((Time.zone.now - self.created_at) / 86400) < 3
  end

  def download_link
    require 'aws-sdk-s3'

    Aws.config.update(
        region: ENV['AWS_REGION'],
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    )

    s3_client = Aws::S3::Client.new

    download = Aws::S3::Object.new(
        key: self.file.path,
        bucket_name: 'drm-sct-test',
        client: s3_client,
        folder: 'uploads'
        )
    .presigned_url(
      :get, expires_in: 60
    )
  end

  def self.packs_filter
    ['All', GENRES, Pack.all.pluck(:title)].flatten
  end

end
