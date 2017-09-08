require 'rails_helper'

describe 'Add novel process', type: :feature do
  before :each do
    sh = create(:source_host)
    user = create(:good_user)
    login_as(user, scope: :user)
  end

  it 'should add novel successful' do
    good_novel_url = attributes_for(:novel)[:source_url]

    visit new_novel_path
    within('#new_novel_form') do
      fill_in '網址', with: good_novel_url
    end
    click_button '添加'
    expect(page).to have_content '書籍建立成功'
  end

  it 'should add novel fail' do
    bad_novel_url = 'https://www.google.com'

    visit new_novel_path
    within('#new_novel_form') do
      fill_in '網址', with: bad_novel_url
    end
    click_button '添加'
    expect(page).to have_content '不合法的網址或標題，書籍建立失敗'
  end
end
