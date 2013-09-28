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
    User.first.username.should eq('azAZ0123456789_-alice_m')
  end

end

describe 'image count' do
  it 'will let us know if this user has images or not' do
    user_with_images = create(:user_with_image)
    user_without_images = create(:user)

    user_with_images.has_images?.should be_true
    user_without_images.has_images?.should be_false
  end
end
