require 'spec_helper'

describe Album do
  it { should validate_presence_of :user_id }

  it 'can be created from a user' do
    album = create(:user).albums.build
    album.save.should eq(true)
  end

  it 'can be referenced to/from a user' do
    user = create(:user)
    album = user.albums.create

    user.albums.first.should eq(album)
    album.user.should eq(user)
  end

  it 'must be deleted if the user is deleted' do
    pending 'test that album is gone if user is deleted'
  end
end
