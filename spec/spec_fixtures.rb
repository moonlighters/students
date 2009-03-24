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
