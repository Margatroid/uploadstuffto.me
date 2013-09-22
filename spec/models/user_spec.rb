require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
end

describe 'username validation' do
  it 'will not accept spaces' do
    user = create(:invite).users.build(
      username: 'This username has spaces',
      email: 'thisisanemail@rspec.com',
      password: 'helloworld'
    )

    user.save.should eq(false)
    User.count.should eq(0)
  end

  it 'will accept alphanumerics, underscores and hyphens' do
    user = create(:invite).users.build(
      username: 'azAZ0123456789_-alice_m',
      email: 'thisisanemail@rspec.com',
      password: 'helloworld'
    )

    user.save.should eq(true)
    User.count.should eq(1)
  end
end
