user = User.find_or_initialize_by(email: Secret.admin.account)
user.password = Secret.admin.password
user.password_confirmation = Secret.admin.password
user.save!
