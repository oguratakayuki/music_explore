class AddFileToYoutubePlaylist < ActiveRecord::Migration
  def change
    add_column :youtube_playlists, :file, :string
  end
end
