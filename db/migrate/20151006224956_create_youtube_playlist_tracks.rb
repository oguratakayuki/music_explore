class CreateYoutubePlaylistTracks < ActiveRecord::Migration
  def change
    create_table :youtube_playlist_tracks do |t|
      t.integer :youtube_playlist_id
      t.integer :track_id

      t.timestamps null: false
    end
  end
end
