class Sex < ActiveRecord::Base
  has_many :users
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :name, :with => /^(?:мужской|женский|не определился)$/

  def self.male; Sex.find_by_name "мужской"; end
  def self.female; Sex.find_by_name "женский"; end
  def self.undefined; Sex.find_by_name "не определился"; end
end
