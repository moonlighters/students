class RemoveUserIdFromForumPost < ActiveRecord::Migration
  def self.up
    ForumPost.all.each do |p|
      p.owner = User.find p.user_id
      p.not_saving_editor_on_update!
      p.save!
    end
    remove_column :forum_posts, :user_id
  end

  def self.down
    add_column :forum_posts, :user_id, :integer
    ForumPost.all.each do |t|
      p.user_id = p.owner
      p.not_saving_editor_on_update!
      p.save!
    end
  end
end
