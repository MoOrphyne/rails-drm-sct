class AddGenreToPacks < ActiveRecord::Migration[5.2]
  def change
    add_column :packs, :genre, :string
  end
end
