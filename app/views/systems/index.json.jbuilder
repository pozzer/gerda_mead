json.array!(@systems) do |system|
  json.extract! system, :id, :description, :api_url, :token
  json.url system_url(system, format: :json)
end
