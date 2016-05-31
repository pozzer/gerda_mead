json.array!(@resource_classes) do |resource_class|
  json.extract! resource_class, :id, :name, :account_id
  json.url resource_class_url(resource_class, format: :json)
end
