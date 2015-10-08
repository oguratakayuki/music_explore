class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :url
      t.string :provider
      t.integer :artist_id
      t.integer :track_id

      t.timestamps null: false
    end
  end
end
