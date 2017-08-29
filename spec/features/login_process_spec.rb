require 'rails_helper'

describe 'Login process', type: :feature do
  before :each do
    @user = create(:good_user)
    @good_user = attributes_for(:good_user)
    @bad_user = attributes_for(:bad_user)
  end

  it 'should log me in' do
    visit new_user_session_path
    within('#new_user') do
      fill_in 'user_email', with: @good_user[:email]
      fill_in 'user_password', with: @good_user[:password]
    end
    click_button '進入'
    expect(page).to have_content 'Signed in successfully'
  end

  it 'should log me out' do
    login_as(@user, scope: :user)

    visit root_path
    click_link '登出'
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  it 'should not log me in (wrong password)' do
    visit new_user_session_path
    within('#new_user') do
      fill_in 'user_email', with: @good_user[:email]
      fill_in 'user_password', with: @bad_user[:password]
    end
    click_button '進入'
    expect(page).to have_content 'Invalid Email or password'
  end

  it 'should not log me in (wrong email)' do
    visit new_user_session_path
    within('#new_user') do
      fill_in 'user_email', with: @bad_user[:email]
      fill_in 'user_password', with: @good_user[:password]
    end
    click_button '進入'
    expect(page).to have_content 'Invalid Email or password'
  end

  it 'should not log me in (wrong email and password)' do
    visit new_user_session_path
    within('#new_user') do
      fill_in 'user_email', with: @bad_user[:email]
      fill_in 'user_password', with: @bad_user[:password]
    end
    click_button '進入'
    expect(page).to have_content 'Invalid Email or password'
  end
end
