class Group < ActiveRecord::Base
  MIN_START_YEAR = 1961
  validates_presence_of   :name, :start_year
  validates_inclusion_of  :start_year,
                          :in => MIN_START_YEAR..Time.now.year,
                          :message => "должен быть от #{MIN_START_YEAR} до #{Time.now.year}"
  has_many  :users,
            :dependent => :nullify

  has_many  :lesson_subject_types,
            :dependent => :destroy

end
