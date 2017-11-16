require 'rails_helper'

describe 'Read novel process', type: :feature do
  before :each do
    sh = create(:source_host)
    @novel = create(:novel, source_host_id: sh.id)
    @chapter1 = create(:chapter1, novel_id: @novel.id)
    @chapter2 = create(:chapter2, novel_id: @novel.id)
    user = create(:good_user)
    login_as(user, scope: :user)
    user.add_to_collection(@novel)
  end

  it 'should read novel successfully' do
    visit root_path
    first('.read').click
    expect(page).to have_content @chapter1.content
  end

  it 'should go to next/prev page' do
    visit root_path
    first('.read').click
    click_link '下一章', match: :first
    expect(page).to have_content @chapter2.content
    click_link '上一章', match: :first
    expect(page).to have_content @chapter1.content
  end

  it 'should go to end_page' do
    visit root_path
    first('.read').click
    click_link '上一章', match: :first
    expect(page).to have_content '已到盡頭'
  end
end
