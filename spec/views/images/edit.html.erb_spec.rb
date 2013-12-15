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

  it "has a thumbnail so you don't forget what you're editing" do
    render
    assert_select "img[src='/thumb/#{ @image.key }.jpg']"
  end
end
