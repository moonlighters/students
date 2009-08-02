class RemoveUserIdFromForumTopic < ActiveRecord::Migration
  def self.up
    ForumTopic.all.each do |t|
      t.owner = User.find t.user_id
      t.save!
    end
    remove_column :forum_topics, :user_id
  end

  def self.down
    add_column :forum_topics, :user_id, :integer
    ForumTopic.all.each do |t|
      t.user_id = t.owner
      t.save
    end
  end
end
