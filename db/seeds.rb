user = User.find_or_initialize_by(email: Secret.admin.account)
user.password = Secret.admin.password
user.password_confirmation = Secret.admin.password
user.save!

sh = SourceHost.find_or_initialize_by(url: 'https://ck101.com/forum-237-1.html')
sh.name = '卡提諾論壇::小說::長篇小說'
sh.save!

# default novels
Novel.create_by_url('https://ck101.com/thread-3397649-1-1.html', sh.id)
Novel.create_by_url('https://ck101.com/thread-3043364-1-1.html', sh.id)
Novel.create_by_url('https://ck101.com/thread-3261183-1-1.html', sh.id)
Novel.create_by_url('https://ck101.com/thread-3368688-1-1.html', sh.id)
Novel.create_by_url('https://ck101.com/thread-2594999-1-1.html', sh.id)
Novel.create_by_url('https://ck101.com/thread-3799148-1-1.html', sh.id)
Novel.create_by_url('https://ck101.com/thread-3536263-1-1.html', sh.id)
Novel.create_by_url('https://ck101.com/thread-3039179-1-1.html', sh.id)
Novel.create_by_url('https://ck101.com/thread-3483293-1-1.html', sh.id)
