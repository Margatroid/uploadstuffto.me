require 'spec_helper'

describe 'homepage behaviour', :type => :feature do
  before { visit '/' }
  it "loads a page with the site's name" do
    expect(page).to have_content 'uploadstuffto.me'
  end

  it 'will display an upload field if and only if logged in' do
    user = Invite.create(:description => 'Test')
      .users
      .create(:email => 'test@test.com', :password => 'panzer vor')

    login_as(user, :scope => :user)
    visit '/'
    expect(page).to have_content 'Upload image(s)'

    logout(:user)
    visit '/'
    expect(page).not_to have_content 'Upload image(s)'
  end

  after(:each) do
    logout(:user)
    Warden.test_reset!
  end
end

describe 'top navigation bar behaviour', :type => :feature do
  before { visit '/' }

  it 'has a link back to the homepage' do
    home_link = page.find('#homepage_link')
    home_link[:href].should eq(root_path)
  end
end

describe 'my recent uploads widget', :type => :feature do
  include UploadHelper, UserFactory

  it 'will show what I just uploaded in the widget' do
    login_as_registered_user
    upload_file

    visit '/'
    recent_upload = page.first('#my_recent_uploads a')
    recent_upload[:href].should eq(
      Rails.application.routes.url_helpers.image_path(Image.first.key)
    )

    thumb = page.first('#my_recent_uploads img')
    thumb[:src].should eq(Image.first.file.url(:thumb))
  end
end

describe "everyone else's recent uploads widget", :type => :feature do
  widget_id = '#recent_uploads'

  context 'when logged in' do
    it 'should not show your own upload' do
    end

    it "should show someone else's upload" do
    end
  end

  context 'when logged out' do
    it "should show everyone's uploads" do
    end
  end
end
