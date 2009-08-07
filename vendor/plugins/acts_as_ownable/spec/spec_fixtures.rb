require 'factory_girl'

Factory.sequence :username do |n|
  "user#{n}"
end

Factory.define :user do |u|
  u.login       { Factory.next :username }
end

Factory.define :ownable do |u|
  u.name  "ownable"
end
