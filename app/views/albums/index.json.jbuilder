json.array!(@albums) do |album|
  json.extract! album, :title
  json.url album_url(album, format: :json)
end
