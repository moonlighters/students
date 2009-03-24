class RenameTopicIdToForumTopicIdInForumPost < ActiveRecord::Migration
  def self.up
    rename_column :forum_posts, :topic_id, :forum_topic_id
  end

  def self.down
    rename_column :forum_posts, :forum_topic_id, :topic_id
  end
end
