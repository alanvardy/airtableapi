# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Permission.create(title: 'Client', value: 0)
Permission.create(title: 'Technician', value: 1)
Permission.create(title: 'Manager', value: 2)

User.create(name: 'Clifford Client', email: 'client@example.com', permission: Permission.find_by(title: 'Client'), password: 'password', password_confirmation: 'password')
User.create(name: 'Terry Technician', email: 'technician@example.com', permission: Permission.find_by(title: 'Technician'), password: 'password', password_confirmation: 'password')
User.create(name: 'Mandy Manager', email: 'manager@example.com', permission: Permission.find_by(title: 'Manager'), password: 'password', password_confirmation: 'password')

Connection.create(user_id: User.find_by(name: 'Clifford Client').id, site_id: Site.all.first.id, title: Site.all.first.fields['Name'])
