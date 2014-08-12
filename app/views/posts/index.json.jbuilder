json.array!(@posts) do |post|
  json.extract! post, :id, :lyric, :artist, :link_url
  json.url post_url(post, format: :json)
end
