json.array!(@itunes) do |itune|
  json.extract! itune, :id, :name, :file
  json.url itune_url(itune, format: :json)
end
