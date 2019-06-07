class User < ApplicationRecord
  has_many :user_packs, dependent: :destroy
  has_many :packs, through: :user_packs

  mount_uploader :photo, PhotoUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  after_create :send_welcome_email

  def to_subscriber
    self.subscriber = true
    Pack.last(3).each do |pack|
      UserPack.create(user_id: self.id, pack_id: pack.id)
    end
    self.save
    send_subscribe_email
  end

  def send_download_email(link, pack)
    UserMailer.with(user: self, link: link, pack: pack).download_link.deliver_now
  end

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end

  def send_subscribe_email
    UserMailer.with(user: self).subscription.deliver_now
  end

  private

end
