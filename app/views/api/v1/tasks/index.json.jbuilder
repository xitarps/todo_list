json.array! @tasks do |task|
  json.title        task.title
  json.description  task.description
  json.user         task.user.email
end
