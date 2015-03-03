class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :image
      t.text :detail

      t.timestamps null: false
    end
  end
end
