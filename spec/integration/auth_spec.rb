require 'spec_helper'

module AuthHelper
  def register(email, key)
    visit '/register'
    pass = 'password'

    fill_in 'Email',                 :with => email
    fill_in 'Password',              :with => pass
    fill_in 'Password confirmation', :with => pass

    fill_in 'Invite key', :with => key if key

    click_button 'Register'
  end

  def login(email, pass)
    visit '/login'
    fill_in 'Email',    :with => email
    fill_in 'Password', :with => pass
    click_button 'Sign in'
  end
end

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
    mail = 'registered@user.com'
    pass = 'cosmoflips'

    User.create(:password => pass, :email => mail)
    login(mail, pass)
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
  end

  it 'will let me make multiple accounts with multiple use key' do
  end
end

describe 'signing out process', :type => :feature do
  include AuthHelper
  before  {
    @registered_user = User.create(
      :email => 'test@user.com', :password => 'use_factory_girl_later'
    )
  }

  it 'should let me sign out on homepage' do
    login(@registered_user.email, @registered_user.password)
    expect(page).to have_content 'Signed in successfully.'

    click_link 'Log out'
    expect(page).to have_content 'You have logged out.'
  end
end