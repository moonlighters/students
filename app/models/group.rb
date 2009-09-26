class Group < ActiveRecord::Base
  validates_presence_of   :name, :start_year
  validates_inclusion_of  :start_year,
                          :in => 1961..Time.now.year,
                          :message => "должен быть от 1961 до " + Time.now.year.to_s,
                          :if => Proc.new {|g| not g.start_year.nil? }
  has_many  :users,
            :dependent => :nullify

  has_many  :lesson_subject_types,
            :dependent => :destroy

end
