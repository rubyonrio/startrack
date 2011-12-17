# -*- encoding : utf-8 -*-
FactoryGirl.define do
  sequence :email do |n|
    "somebody#{n}@example.com"
  end

  factory :project do
    name "First Journey"
    users { |u| [u.association(:user)] }
  end

  factory :user do
    name "Spok"
    email { Factory.next(:email) }
    password "test123"
  end

  factory :task do
    name "Create Enterprise"
    project
    user
    status
    type
  end

  factory :status do
    name "TODO"
  end

  factory :type do
    name "Feature"
  end

  factory :comment do
    description "I got some money to help you out with this issue!"
    task
    user
  end
end
