require 'spec_helper'

describe "home/root.html.erb" do
  it 'shows the correct title' do
    assign(:recently_uploaded, [])
    render(template: 'home/root', layout: 'layouts/application')
    expect(view.content_for(:title)).to(
      eq(ERB::Util.h("Home | uploadstuffto.me").to_s))
  end
end
