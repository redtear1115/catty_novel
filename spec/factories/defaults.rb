FactoryGirl.define do
  factory :source_host, class: SourceHost do
    url 'https://ck101.com/forum-237-1.html'
    name '卡提諾論壇::小說::長篇小說'
  end

  factory :novel, class: Novel do
    source_url 'https://ck101.com/thread-3397649-1-1.html'
    last_sync_url 'https://ck101.com/thread-3397649-1-1.html'
  end

  factory :chapter1, class: Chapter do
    content 'here_is_my_whatever_content1'
    external_id 'external_id1'
    number 1
  end

  factory :chapter2, class: Chapter do
    content 'here_is_my_whatever_content2'
    external_id 'external_id2'
    number 2
  end
end
