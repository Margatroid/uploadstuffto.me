require 'spec_helper'

describe 'registration with invites' do
  before  { @onceoff = Invite.create(:description => 'Test') }

  it 'should let me register an account with an invite' do
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
