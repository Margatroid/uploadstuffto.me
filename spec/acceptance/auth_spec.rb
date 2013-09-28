require 'spec_helper'

describe 'register account with a onceoff invite', :type => :feature do
  include AuthHelper
  before  { @onceoff = Invite.create(:description => 'Test') }

  it 'should show registration page at /register' do
    visit '/register'
    expect(page).to have_content 'Register new account'
  end

  it 'should let me register an account with an invite' do
    register('hello@world.com', @onceoff.key)
    expect(page).to have_content 'You have signed up successfully'
  end
end

describe 'the login process', :type => :feature do
  include AuthHelper
  it 'should show login page at /login' do
    visit '/login'
    expect(page).to have_content 'Log in'
  end

  it 'should let me login' do
    user = create(:user)
    login(user.email, user.password)
    expect(page).to have_content 'Signed in successfully.'
  end
end

describe 'registration with invalid keys', :type => :feature do
  include AuthHelper
  it 'will refuse invalid keys' do
    register('invalid@key.com', 'not_a_valid_key')
    expect(page).to have_content 'invalid'
    User.all.count.should be 0
  end

  it 'will refuse with no key' do
    register('invalid@key.com', nil)
    expect(page).to have_content 'invalid'
    User.all.count.should be 0
  end

  it 'will not let me register again with a used onceoff key' do
    onceoff = Invite.create(:description => 'Test')

    register('hello@world.com', onceoff.key)
    expect(page).to have_content 'You have signed up successfully'

    click_link 'Log out'

    register('hello_again@world.com', onceoff.key)
    expect(page).to have_content 'invalid'
    User.all.count.should be 1
  end

  it 'will let me make multiple accounts with multiple use key' do
    multiple = Invite.create(:description => 'Test', :usage => 5)

    (1..5).each do |i|
      register("hello#{ i }@world.com", multiple.key)
      expect(page).to have_content 'You have signed up successfully'
      click_link 'Log out'
    end

    register('sixth@time.com', multiple.key)
    expect(page).to have_content 'invalid'
    User.all.count.should be 5
  end
end

describe 'signing out process', :type => :feature do
  include AuthHelper

  it 'should let me sign out on homepage' do
    user = create(:user)
    login(user.email, user.password)
    expect(page).to have_content 'Signed in successfully.'

    click_link 'Log out'
    expect(page).to have_content 'You have logged out.'
  end
end