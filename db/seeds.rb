# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Daley', city: cities.first)

Status.delete_all
["TODO", "Scheduled", "Current", "Done"].each do |status|
  Status.create :name => status
end

Type.delete_all
["Feature", "Bug"].each do |type|
  Type.create :name => type
end

Estimate.delete_all
["Fast", "Medium", "Longstanding", "Very longstanding"].each do |estimate|
  Estimate.create :name => estimate
end

