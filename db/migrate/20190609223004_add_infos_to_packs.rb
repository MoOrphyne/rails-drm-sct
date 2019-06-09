class AddInfosToPacks < ActiveRecord::Migration[5.2]
  def change
    add_column :packs, :infos, :string, array: true
    add_index :packs, :infos, using: 'gin'
  end
end
