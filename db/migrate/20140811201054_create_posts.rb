class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :lyric
      t.string :artist
      t.string :link_url

      t.timestamps
    end
  end
end
