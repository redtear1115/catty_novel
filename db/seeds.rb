# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

SourceHost.find_or_create_by(name: '卡提諾論壇::小說::長篇小說', url: 'https://ck101.com/forum-237-1.html')

User.create(email: Secret.default_email, password: Secret.default_password, password_confirmation: Secret.default_password)