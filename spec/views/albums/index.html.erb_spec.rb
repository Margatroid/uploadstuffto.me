require 'spec_helper'

describe "albums/index" do
  before(:each) do
    assign(:albums, [
      stub_model(Album,
        :title => 'Title',
        :key   => 'hello'
      ),
      stub_model(Album,
        :title => 'Title',
        :key   => 'world'
      )
    ])
  end

  it "renders a list of albums" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "div>h3", :text => "Title".to_s, :count => 2
  end
end

describe "albums/index" do
  before(:each) do
    assign(:albums, [
      stub_model(Album,
        :title  => 'Title',
        :key    => 'hello',
        :public => true
      ),
      stub_model(Album,
        :title  => 'Title',
        :key    => 'world',
        :public => true
      )
    ])

    @user = create(:user)
    assign(:user, @user)
  end

  it "will have a link to the user's profile if we're looking at a user's albums" do
    render
    rendered.should have_link(@user.username, href: user_path(@user))
  end
end

describe 'albums/index' do
  before(:each) do
    assign(:albums, [
      stub_model(Album,
        :title   => 'My public album',
        :key     => 'public',
        :public  => true,
        :user_id => 1
      ),
      stub_model(Album,
        :title   => 'My private album',
        :key     => 'private',
        :public  => true,
        :user_id => 1
      )
    ])

    @user = create(:user)
    assign(:user, @user)
  end

  context 'when logged out' do
    it 'will show my public album' do
      render
      expect(rendered).to match('My public album')
    end

    it 'will not show my private album' do
      render
      expect(rendered).to_not match('My private album')
    end
  end

  context 'when logged in' do
    before(:each) do
      login_as(@user, :scope => :user)
    end

    it 'will show my public album' do
      render
      expect(rendered).to match('My public album')
    end

    it 'will show my private album' do
      render
      expect(rendered).to match('My private album')
    end

    after(:each) do
      logout(:user)
      Warden.test_reset!
    end
  end
end