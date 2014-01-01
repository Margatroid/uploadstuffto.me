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
