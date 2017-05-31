user = User.find_or_initialize_by(email: Secret.admin.account)
user.password = Secret.admin.password
user.password_confirmation = Secret.admin.password
user.save!

sh = SourceHost.find_or_initialize_by(url: 'https://ck101.com/forum-237-1.html')
sh.name = '卡提諾論壇::小說::長篇小說'
sh.save!
