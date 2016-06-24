json.array!(@archives) do |archive|
  json.extract! archive, :id, :user_id
  json.url archive_url(archive, format: :json)
end
