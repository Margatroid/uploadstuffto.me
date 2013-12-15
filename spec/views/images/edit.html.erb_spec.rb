require 'spec_helper'

describe "images/edit" do
  before(:each) do
    @image = assign(:image, stub_model(Image))
    @image.key = 'hello'
  end

  it "renders the edit image form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #assert_select "form[action=?][method=?]", image_path(@image), "post" do
    #end
    assert_select "form#image_public[value=#{ @image.public? }]"
  end
end
