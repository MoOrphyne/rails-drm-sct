class RenameAudioToFile < ActiveRecord::Migration[5.2]
  def change
    rename_column :packs, :audio, :file
  end
end
