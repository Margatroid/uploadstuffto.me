require 'spec_helper'

describe Image do
  let(:valid_attributes) do
    extend ActionDispatch::TestProcess
    { :user_id => 1, :file => fixture_file_upload('chicken_rice.jpg') }
  end

  it 'will have a key' do
    image = Image.create! valid_attributes
    image.key should exist
  end
end
