class AddLastEditorIdToForumPost < ActiveRecord::Migration
  def self.up
    add_column :forum_posts, :last_editor_id, :integer
  end

  def self.down
    remove_column :forum_posts, :last_editor_id
  end
end
