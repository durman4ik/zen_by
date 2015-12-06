json.array!(@contact_infos) do |contact_info|
  json.extract! contact_info, :id
  json.url contact_info_url(contact_info, format: :json)
end
