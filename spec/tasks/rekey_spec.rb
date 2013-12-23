describe 'rekey:all' do
  include_context 'rake'

  before(:each) do
    user = create(:user_with_images)
    FileUtils.stub(:mv).and_return(true)
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

  it 'will rename all files' do
    old_thumbnail_paths = Image.all.map { |image| image.file.path(:thumb) }
    old_original_paths  = Image.all.map { |image| image.file.path() }

    subject.invoke # Run rekey:all

    new_thumbnail_paths = Image.all.map { |image| image.file.path(:thumb) }
    new_original_paths  = Image.all.map { |image| image.file.path() }

    expect(old_thumbnail_paths & new_thumbnail_paths).to be_empty
    expect(old_original_paths & new_original_paths).to be_empty
  end
end