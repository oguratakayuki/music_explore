class CreateYoutubePlaylists < ActiveRecord::Migration
  def change
    create_table :youtube_playlists do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
