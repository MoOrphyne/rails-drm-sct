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

  def download_link
    require 'aws-sdk'

    Aws.config.update(
        region: ENV['AWS_REGION'],
        # endpoint: 'https://s3.eu-west-2.amazonaws.com',
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    )

    s3_client = Aws::S3::Client.new

    download = Aws::S3::Object.new(
        key: 'Sample.zip',
        bucket_name: 'drm-sct-test',
        client: s3_client
        )
    .presigned_url(
      :get, expires_in: 60 * 60
    )
  end
end
