class AddPhotoToPacks < ActiveRecord::Migration[5.2]
  def change
    add_column :packs, :photo, :string
  end
end
