class CreateYoutubePlaylistMovies < ActiveRecord::Migration
  def change
    create_table :youtube_playlist_movies do |t|
      t.integer :youtube_playlist_id
      t.integer :movie_id

      t.timestamps null: false
    end
  end
end
