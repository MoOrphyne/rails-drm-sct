class Order < ApplicationRecord
  after_create :default

  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :packs, through: :order_items

  def total
    self.packs.pluck(:price_cents).reduce(:+)
  end

  def default
    self.update(status: 'pending')
  end
end
