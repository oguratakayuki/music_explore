class AddMbIdToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :mbid, :string, :after => :name
  end
end
