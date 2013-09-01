require 'spec_helper'

describe 'register account with a onceoff invite', :type => :feature do
  before  { @onceoff = Invite.create(:description => 'Test') }

  it 'should show registration page at /register' do
    visit '/register'
    expect(page).to have_content 'Register new account'
  end

  it 'should let me register an account with an invite' do
    pass = 'password'
    visit '/register'

    fill_in 'Email',                 :with => 'hello@world.com'
    fill_in 'Password',              :with => pass
    fill_in 'Password confirmation', :with => pass
    fill_in 'Invite key',            :with => @onceoff.key

    click_button 'Register'
    expect(page).to have_content 'You have signed up successfully'
  end
end

describe 'the login process', :type => :feature do
  it 'should show login page at /login' do
    visit '/login'
    expect(page).to have_content 'Log in'
  end

  it 'should let me login' do
    mail = 'registered@user.com'
    pass = 'cosmoflips'
    visit '/login'

    User.create(:password => pass, :email => mail)

    fill_in 'Email',    :with => mail
    fill_in 'Password', :with => pass

    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully.'
  end
end

describe 'registration with invalid keys', :type => :feature do
  it 'will refuse invalid keys' do
    pass = 'password'
    visit '/register'

    fill_in 'Email',                 :with => 'invalid@key.com'
    fill_in 'Password',              :with => pass
    fill_in 'Password confirmation', :with => pass
    fill_in 'Invite key',            :with => 'not_a_valid_key'

    click_button 'Register'
    expect(page).to have_content 'invalid'
    User.all.count.should be_false
  end

  it 'will refuse with no key' do
  end

  it 'will not let me register again with a used onceoff key' do
  end

  it 'will let me make multiple accounts with multiple use key' do
  end
end
