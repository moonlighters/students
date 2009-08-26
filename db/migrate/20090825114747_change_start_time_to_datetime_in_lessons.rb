class ChangeStartTimeToDatetimeInLessons < ActiveRecord::Migration
  def self.up
    change_column :lessons, :start_time, :datetime
  end

  def self.down
    change_column :lessons, :start_time, :time
  end
end
