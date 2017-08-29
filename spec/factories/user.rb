FactoryGirl.define do
  factory :good_user, class: User do
    email 'good_user@catty-novel.cc'
    password 'password'
    password_confirmation 'password'
  end

  factory :bad_user, class: User do
    email 'bad_user@catty-novel.cc'
    password 'not_my_password'
    password_confirmation 'not_my_password'
  end
end
