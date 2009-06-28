require 'factory_girl'

Factory.define :forum do |f|
  f.title       "Cool forum"
  f.description "This forum is the best!"
end

Factory.sequence :username do |n|
  "user#{n}"
end

Factory.define :user do |u|
  u.login       { Factory.next :username }
  u.password    "123456"
  u.password_confirmation "123456"
end

Factory.define :forum_topic do |t|
  t.title       "cool topic"
  t.description "sdefghj"
  t.association :user, :factory => :user
  t.association :forum, :factory => :forum
end

Factory.define :forum_post do |f|
  f.body "it's a post\nabout this and that"
  f.association :user, :factory => :user
  f.association :topic, :factory => :forum_topic
end

Factory.define :forum_topic_viewing do |v|
  v.association :user, :factory => :user
  v.association :topic, :factory => :forum_topic
  v.association :post, :factory => :forum_post
end

Factory.define :lesson_type do |t|
  t.name "лекция"
end

Factory.define :lesson_subject do |s|
  s.name "ММФ"
  s.term 4
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
  l.association :group, :factory => :group
  l.association :subject_type, :factory => :lesson_subject_type
  l.day_of_week 2
  l.start_time Time.mktime(1970, "jan", 1, 12, 20)
  l.duration 1.hour + 35.minutes
  l.everyweek false
  l.odd_weeks true
end
