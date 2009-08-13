class AddLastPostIdToForumTopic < ActiveRecord::Migration
  def self.up
    add_column :forum_topics, :last_post_id, :integer
  end

  def self.down
    remove_column :forum_topics, :last_post_id
  end
end
