class CreateUserPacks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_packs do |t|
      t.references :user, foreign_key: true
      t.references :pack, foreign_key: true

      t.timestamps
    end
  end
end
