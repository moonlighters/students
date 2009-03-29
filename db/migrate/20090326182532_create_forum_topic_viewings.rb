class CreateForumTopicViewings < ActiveRecord::Migration
  def self.up
    create_table :forum_topic_viewings do |t|
      t.integer :user_id
      t.integer :forum_topic_id
      t.integer :forum_post_id

      t.timestamps
    end
  end

  def self.down
    drop_table :forum_topic_viewings
  end
end
