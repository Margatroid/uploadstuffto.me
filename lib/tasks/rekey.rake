namespace :rekey do
  desc 'Re-key all images'
  task :all do
    Image.all.each do |image|
      image.key = loop do
        tmp = SecureRandom.urlsafe_base64(4, false)
        break tmp unless Image.where(key: tmp).exists?
      end
      image.save
    end
  end
end