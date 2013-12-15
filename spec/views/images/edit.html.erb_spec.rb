require 'spec_helper'

describe "images/edit" do
  before(:each) do
    @image = assign(:image, stub_model(Image, :user_id => 1))
    @image.file = File.open('public/test_image.jpg') # Dirty
    @image.save!
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
    assert_select "img[src='/thumb/test_imagejpg']"
  end
end
