require 'spec_helper'

describe Image do
  let(:valid_attributes) do
    extend ActionDispatch::TestProcess
    { :user_id => 1, :file => fixture_file_upload('chicken_rice.jpg') }
  end

  it 'will have a key' do
    image = Image.create! valid_attributes

    Image.all.should have(1).item
    Image.first.key.should match(/\S{6}/)
  end
end

describe 'never show recent uploads from non-featured profiles' do
  let(:featured_valid_attributes) do
    extend ActionDispatch::TestProcess
    { :user_id => 1, :file => fixture_file_upload('chicken_rice.jpg') }
  end

  let(:valid_attributes) do
    extend ActionDispatch::TestProcess
    { :user_id => 2, :file => fixture_file_upload('chicken_rice.jpg') }
  end

  it 'will never get recent images from non-featured profiles' do
    show_on_homepage = Image.create! featured_valid_attributes
    cannot_show_on_homepage = Image.create! valid_attributes

    featured_profile = create(:user) # User ID 1.
    regular_profile  = create(:user) # User ID 2.

    featured_profile.featured = true
    featured_profile.save

    Image.recently_uploaded.should eq([show_on_homepage])
  end
end