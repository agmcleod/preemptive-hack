json.array!(@hackday_organizations) do |hackday_organization|
  json.extract! hackday_organization, :name
  json.url hackday_organization_url(hackday_organization, format: :json)
end