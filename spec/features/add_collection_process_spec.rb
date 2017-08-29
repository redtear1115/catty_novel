require 'rails_helper'

describe 'Add collection process', type: :feature do
  before :each do
    sh = create(:source_host)
    @novel = create(:novel, source_host_id: sh.id)
    create(:chapter1, novel_id: @novel.id)
    create(:chapter2, novel_id: @novel.id)
    @user = create(:good_user)
    login_as(@user, scope: :user)
  end

  it 'should add collection successfully' do
    visit novels_path
    click_button '加入收藏'
    expect(page).to have_content '收藏建立成功'
  end

  it 'should add collection fail' do
    @novel.last_sync_url = nil
    @novel.save!

    visit novels_path
    click_button '加入收藏'
    expect(page).to have_content '收藏建立失敗'
  end

  it 'should delete collection successfully' do
    @user.add_to_collection(@novel)

    visit root_path
    click_link '移除'
    expect(page).to have_content '收藏刪除成功'
  end
end
