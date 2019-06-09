class AddDetailsToPacks < ActiveRecord::Migration[5.2]
  def change
    add_column :packs, :file_size, :string
    add_column :packs, :content_type, :string
  end
end
