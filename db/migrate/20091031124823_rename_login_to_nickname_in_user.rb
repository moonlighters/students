class RenameLoginToNicknameInUser < ActiveRecord::Migration
  def self.up
    rename_column :users, :login, :nickname
  end

  def self.down
    rename_column :users, :nickname, :login
  end
end
