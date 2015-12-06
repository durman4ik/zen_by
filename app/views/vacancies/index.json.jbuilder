json.array!(@vacancies) do |vacancy|
  json.extract! vacancy, :id
  json.url vacancy_url(vacancy, format: :json)
end
