Factory.sequence(:description) {|value| "Description #{value}"}
Factory.sequence(:name) {|value| "Startrack Member#{value}"}
Factory.sequence(:email) { "email@startrack.com" }
Factory.sequence(:password) { "PaSsWoRd" }

Factory.define :project do |project|
  project.name Factory.next(:name)
  project.description Factory.next(:description)
end

Factory.define :story do |story|
  story.name Factory.next(:name)
  story.description Factory.next(:description)
end

Factory.define :user do |user|
  user.name Factory.next(:name)
  user.email Factory.next(:email)
  user.password Factory.next(:password)
end
