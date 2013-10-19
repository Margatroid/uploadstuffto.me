require 'spec_helper'

describe "users/show.html.erb" do
  it 'should have a username' do
    user = stub_model(User, username: 'berg_katze', created_at: DateTime.now)
    assign(:user, user)
    render template: 'users/show'
    rendered.should have_text("berg_katze's profile")
  end

  context 'when logged in' do
    before(:each) do
      @me  = create(:user_with_image)
      @you = create(:user_with_image)
      login_as(@me, :scope => :user)
    end

    it 'will show edit mode on your profile' do
      assign(:user, @me)
      assign(:recent_uploads, @me.recently_uploaded_paginate(1))
      render template: 'users/show'
      rendered.should have_text('Edit mode')
    end

    it "will not show edit mode on someone else's profile" do
      assign(:user, @you)
      assign(:recent_uploads, @you.recently_uploaded_paginate(1))
      render template: 'users/show'
      rendered.should_not have_text('Edit mode')
    end

    after(:each) do
      logout(:user)
      Warden.test_reset!
    end
  end

  context 'when logged out' do
    it 'will not show any editing controls' do
      @me = create(:user_with_image)
      assign(:user, @me)
      assign(:recent_uploads, @me.recently_uploaded_paginate(1))

      render template: 'users/show'
      rendered.should_not have_text('Edit mode')
    end
  end
end
