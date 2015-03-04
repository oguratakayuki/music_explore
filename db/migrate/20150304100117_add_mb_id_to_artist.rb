class AddMbIdToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :mb_id, :integer, :after => :name
  end
end
