class AddPriceToPacks < ActiveRecord::Migration[5.2]
  def change
    add_monetize :packs, :price, currency: { present: false }
  end
end
