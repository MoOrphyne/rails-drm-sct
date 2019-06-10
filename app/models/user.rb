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
    self.subscriber == nil ? new_sub(3) : re_sub
  end

  def new_sub(n)
    self.update(subscriber: true)
    last_packs(n)
    send_subscribe_email(Pack.last(n))
  end

  def re_sub
    self.update(subscriber: true)
    send_subscribe_email
  end

  def got_it?(pack)
    self.packs.include?(pack)
  end

  def user_packs_filter
    ['All', Pack::GENRES, self.packs.pluck(:title)].flatten
  end

  def send_download_email(link, pack)
    UserMailer.with(user: self, link: link, pack: pack).download_link.deliver_now
  end

  def send_new_pack_email(pack)
    UserMailer.with(user: self, pack: pack).new_pack.deliver_now
  end

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end

  def send_subscribe_email(packs = [])
    UserMailer.with(user: self, packs: packs).subscription.deliver_now
  end

  private

  def last_packs(n)
    Pack.last(n).each { |pack| UserPack.create(user_id: self.id, pack_id: pack.id) }
  end

end
