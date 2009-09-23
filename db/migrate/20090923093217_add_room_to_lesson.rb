class AddRoomToLesson < ActiveRecord::Migration
  def self.up
    add_column :lessons, :room, :string
  end

  def self.down
    remove_column :lessons, :room
  end
end
