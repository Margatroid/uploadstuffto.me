require 'spec_helper'

describe Album do
  it { should validate_presence_of :user_id }

  it 'can be created from a user' do
    album = create(:user).albums.build
    album.save.should eq(true)
  end

  it 'cannot be created on its own' do
    album = Album.new(title: 'boom')
    expect { album.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'can be referenced to/from a user' do
    user = create(:user)
    album = user.albums.create

    user.albums.first.should eq(album)
    album.user.should eq(user)
  end

  it 'must be deleted if the user is deleted' do
    album = create(:album)
    Album.all.count.should eq(1)
    album.user.destroy
    Album.all.count.should eq(0)
  end
end
