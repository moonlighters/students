class Group < ActiveRecord::Base
  validates_presence_of   :name, :start_year
  validates_inclusion_of  :start_year,
                          :in => 1961..Time.now.year
end
