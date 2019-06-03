class AddAudioToPacks < ActiveRecord::Migration[5.2]
  def change
    add_column :packs, :audio, :string
  end
end
