class CreateForumTopics < ActiveRecord::Migration
  def self.up
    create_table :forum_topics do |t|
      t.string :title
      t.string :description
      t.integer :view_count
      t.integer :user_id
      t.integer :forum_id

      t.timestamps
    end
  end

  def self.down
    drop_table :forum_topics
  end
end
