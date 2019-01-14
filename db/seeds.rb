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

User.create(name: 'Clifford Client', email: 'client@example.com', permission: Permission.find_by(title: 'Client'), password: 'alanvardy', password_confirmation: 'alanvardy')
User.create(name: 'Mae "Maeby" Fünke', email: 'mfunke@example.com', permission: Permission.find_by(title: 'Client'), password: 'alanvardy', password_confirmation: 'alanvardy')
User.create(name: 'Byron "Buster" Bluth', email: 'bbluth@example.com', permission: Permission.find_by(title: 'Client'), password: 'alanvardy', password_confirmation: 'alanvardy')
User.create(name: 'George Michael Bluth', email: 'gmbluth@example.com', permission: Permission.find_by(title: 'Client'), password: 'alanvardy', password_confirmation: 'alanvardy')
User.create(name: 'Terry Technician', email: 'technician@example.com', permission: Permission.find_by(title: 'Technician'), password: 'alanvardy', password_confirmation: 'alanvardy')
User.create(name: 'Michael Bluth', email: 'mbluth@example.com', permission: Permission.find_by(title: 'Technician'), password: 'alanvardy', password_confirmation: 'alanvardy')
User.create(name: 'Lindsay Bluth Fünke', email: 'lfunke@example.com', permission: Permission.find_by(title: 'Technician'), password: 'alanvardy', password_confirmation: 'alanvardy')
User.create(name: 'Tobias Onyango Fünke', email: 'tfunke@example.com', permission: Permission.find_by(title: 'Technician'), password: 'alanvardy', password_confirmation: 'alanvardy')
User.create(name: 'Mandy Manager', email: 'manager@example.com', permission: Permission.find_by(title: 'Manager'), password: 'alanvardy', password_confirmation: 'alanvardy')
User.create(name: 'George Oscar Bluth, Sr.', email: 'gbluth@example.com', permission: Permission.find_by(title: 'Manager'), password: 'alanvardy', password_confirmation: 'alanvardy')
User.create(name: 'Lucille Bluth', email: 'lbluth@example.com', permission: Permission.find_by(title: 'Manager'), password: 'alanvardy', password_confirmation: 'alanvardy')

Connection.create(user_id: User.find_by(name: 'Clifford Client').id, site_id: Site.all[0].id, title: Site.all[0].fields['Name'])
Connection.create(user_id: User.find_by(name: 'Clifford Client').id, site_id: Site.all[3].id, title: Site.all[3].fields['Name'])
Connection.create(user_id: User.find_by(name: 'Clifford Client').id, site_id: Site.all[4].id, title: Site.all[4].fields['Name'])
Connection.create(user_id: User.find_by(name: 'Mae "Maeby" Fünke').id, site_id: Site.all[1].id, title: Site.all[1].fields['Name'])
Connection.create(user_id: User.find_by(name: 'Mae "Maeby" Fünke').id, site_id: Site.all[2].id, title: Site.all[2].fields['Name'])
Connection.create(user_id: User.find_by(name: 'Byron "Buster" Bluth').id, site_id: Site.all[1].id, title: Site.all[1].fields['Name'])
Connection.create(user_id: User.find_by(name: 'George Michael Bluth').id, site_id: Site.all[0].id, title: Site.all[0].fields['Name'])
