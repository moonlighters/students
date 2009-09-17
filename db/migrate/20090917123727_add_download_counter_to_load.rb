class AddDownloadCounterToLoad < ActiveRecord::Migration
  def self.up
    add_column :loads, :download_counter, :integer, :default => 0
  end

  def self.down
    remove_column :loads, :download_counter
  end
end
