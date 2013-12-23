namespace :rekey do
  desc 'Re-key all images'
  task :all => :environment do

    Image.all.each do |image|
      old_key = image.key

      image.key = loop do
        tmp = SecureRandom.urlsafe_base64(4, false)
        break tmp unless Image.where(key: tmp).exists?
      end

      # Rename stored thumbnails. and original by reassigning them.
      # Get filepaths of thumbnail and original.
      original_file_path = image.file.path
      thumbnail_file_path = image.file.path(:thumb)

      new_original_path = original_file_path.gsub(old_key, image.key)
      new_thumbnail_path = thumbnail_file_path.gsub(old_key, image.key)

      FileUtils.mv(thumbnail_file_path, new_thumbnail_path)
      FileUtils.mv(original_file_path, new_original_path)

      image.file_file_name = image.file_file_name.gsub(old_key, image.key)
      image.save!
    end
  end
end