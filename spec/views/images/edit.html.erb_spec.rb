require 'spec_helper'

describe "images/edit" do
  before(:each) do
    @image = assign(:image, stub_model(Image, :user_id => 1))
    @image.file = File.open('public/test_image.jpg') # Dirty
    @image.public = false
    @image.save!
  end

  it "renders the edit image form" do
    render
    assert_select "input#image_public[value=false]"
  end

  it "renders the checkbox properly" do
    @image.public = true
    @image.save!
    render
    assert_select "input#image_public[value=true]"
  end

  it "has a thumbnail so you don't forget what you're editing" do
    render
    assert_select "img[src='/thumb/test_imagejpg']"
  end
end
