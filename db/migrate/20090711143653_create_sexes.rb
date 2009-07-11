class CreateSexes < ActiveRecord::Migration
  def self.up
    create_table :sexes do |t|
      t.string :name
    end
    add_column :users, :sex_id, :integer

    ["не определился", "мужской", "женский"].each do |s|
      Sex.create! :name => s
    end

    User.all.each do |u|
      u.sex = Sex.undefined
      u.save
    end
  end

  def self.down
    remove_column :users, :sex_id
    drop_table :sexes
  end
end
