json.array!(@demos) do |demo|
  json.extract! demo, :id, :first_name, :last_name, :company, :email, :employees, :interest
  json.url demo_url(demo, format: :json)
end
