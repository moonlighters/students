require 'factory_girl'

TERM = 4

Factory.sequence :username do |n|
  "user#{n}"
end

Factory.define :user do |u|
  u.login       { Factory.next :username }
  u.password    "123456"
  u.password_confirmation "123456"
  u.sex         Sex.undefined
  u.association :group, :factory => :group
end

Factory.define :load do |l|
  l.name "Keygen"
  l.description "It works with every soft!"
  l.association :owner, :factory => :user
  l.tag_list "fun, sexy"
  l.file File.open("Rakefile")
end

Factory.define :lesson_type do |t|
  t.name "лекция"
end

Factory.define :lesson_subject do |s|
  s.name "Методы МатФизики"
  s.short_name "ММФ"
  s.term TERM
end

Factory.define :group do |g|
  g.name "7371"
  g.start_year 2007
end

Factory.define :teacher do |t|
  t.name "Сергей Андреевич"
  t.surname "Тресков"
  t.phone "33333333"
  t.email "mail@mail.ru"
end

Factory.define :lesson_subject_type do |l|
  l.association :lesson_type, :factory => :lesson_type
  l.association :subject, :factory => :lesson_subject
  l.association :group, :factory => :group
  l.association :teacher, :factory => :teacher
end

Factory.define :lesson do |l|
  l.association :subject_type, :factory => :lesson_subject_type
  l.association :group, :factory => :group
  l.term TERM
  l.day_of_week 2
  l.start_time Time.utc(*Lesson::DEFAULT_DATE + [12, 20])
  l.duration 1.hour + 35.minutes
  l.everyweek true 
  l.odd_weeks nil
  l.room "429"
end
