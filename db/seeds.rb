# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Populate standard roles
Role.delete_all

Role.create! description: "site_admin"
Role.create! description: "author"

User.create! name: "site_admin",
  password: "f",
  password_confirmation: "f",
  role_id: ROLE_ADMIN

User.create! name: "ff",
  password: "f",
  password_confirmation: "f",
  role_id: ROLE_AUTHOR
