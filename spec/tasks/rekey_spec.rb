describe 'rekey:all' do
  include_context 'rake'

  before(:each) do
    user = create(:user_with_images)
  end

  it 'rekeys images' do
    expect(Image.all).not_to be_empty
    existing_keys = Image.all.map { |image| image.key }

    subject.invoke # Run rekey:all

    new_keys = Image.all.map { |image| image.key }

    expect(new_keys.count).to be(existing_keys.count)
    # Intersect existing_keys and new_keys, should not be any elements.
    expect(existing_keys & new_keys).to be_empty
  end

  it 'will rename thumbnail files' do
  end

  it 'will rename original image files' do
  end
end