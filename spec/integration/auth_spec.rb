require 'spec_helper'

describe 'registration with invites', :type => :feature do
  before  { @onceoff = Invite.create(:description => 'Test') }

  it 'should let me register an account with an invite' do
    pass = 'password'
    visit '/register'

    fill_in 'Email',                 :with => 'hello@world.com'
    fill_in 'Password',              :with => pass
    fill_in 'Password confirmation', :with => pass

    click_button 'Sign up'
    expect(page).to have_content 'You have signed up successfully'
  end

  it 'should show registration page at /register' do
    visit '/register'
  end

  it 'should show login page at /login' do
    visit '/login'
  end

  it 'should refuse registration with a bad key' do
  end

  it 'should refuse registration with no key' do
  end

  it 'should not let me use a onceoff key more than once' do
  end

  it 'should let me make multiple accounts with a multi-use invite' do
  end
end
