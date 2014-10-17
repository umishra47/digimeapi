json.array!(@jobs) do |job|
  json.extract! job, :id, :title, :location, :description
  json.url job_url(job, format: :json)
end
