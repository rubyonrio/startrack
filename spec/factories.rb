Factory.define(:name) {|value| "Name #{value}"}

Factory.define :project do |project|
  project.name Factory.sequence(:name)
end
