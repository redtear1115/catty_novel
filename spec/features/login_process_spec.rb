require 'rails_helper'

describe 'Login process', type: :feature do
  before :all do
    @test_email = 'user@example.com'
    @test_password = 'password'
    @wrong_email = 'wrong@example.com'
    @wrong_password = 'notmypassword'
    User.create(email: @test_email, password: @test_password, password_confirmation: @test_password)
  end

  it 'should signs me in' do
    visit new_user_session_path
    within('#new_user') do
      fill_in 'user_email', with: @test_email
      fill_in 'user_password', with: @test_password
    end
    click_button '進入'
    expect(page).to have_content 'Signed in successfully'
  end

  it 'should not log me in (wrong password)' do
    visit new_user_session_path
    within('#new_user') do
      fill_in 'user_email', with: @test_email
      fill_in 'user_password', with: @wrong_password
    end
    click_button '進入'
    expect(page).to have_content 'Invalid Email or password'
  end

  it 'should not log me in (wrong email)' do
    visit new_user_session_path
    within('#new_user') do
      fill_in 'user_email', with: @wrong_email
      fill_in 'user_password', with: @test_password
    end
    click_button '進入'
    expect(page).to have_content 'Invalid Email or password'
  end

  it 'should not log me in (wrong email and password)' do
    visit new_user_session_path
    within('#new_user') do
      fill_in 'user_email', with: @wrong_email
      fill_in 'user_password', with: @wrong_password
    end
    click_button '進入'
    expect(page).to have_content 'Invalid Email or password'
  end
end
