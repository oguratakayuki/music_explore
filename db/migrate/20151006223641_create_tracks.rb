class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title
      t.text :description
      t.date :release_date

      t.timestamps null: false
    end
  end
end
