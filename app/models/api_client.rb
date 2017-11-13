class ApiClient

  def initialize
    @client = AFMotion::Client.build('https://guarded-cove-75567.herokuapp.com/') do
      header "Accept", "application/json"

      response_serializer :json
    end
  end

  def token(username, password, &block)
    @client.post("api/login", email: username, password: password) do |result|
      block.call(result.object)
    end
  end

  def pull_tasks(type, &block)
    auth_token = App::Persistence['auth_token']
    @client.headers["Authorization"] = "Token token=#{App::Persistence['auth_token']}"
    @client.post("api/user_tasks", list_type: type) do |result|
      save_to_local_database(result.object['tasks'], type)
      block.call(result.object)
    end
  end

  def save_to_local_database(tasks, type)
    tasks.each do |task|
      local_task = Task.where(api_id: task[:id])
      if local_task.any?
        local_task = local_task.first
        local_task.api_id = task[:id]
        local_task.title = task[:title]
        local_task.complete = task[:complete?]
        local_task.details = task[:description]
        local_task.due_date = NSDate.dateWithNaturalLanguageString(task[:due_date])
        local_task.type = type
      else
        Task.create(api_id: task[:id],
                    title: task[:title],
                    complete: task[:complete?],
                    details: task[:description],
                    due_date: NSDate.dateWithNaturalLanguageString(task[:due_date]),
                    type: type
                    )
      end
      Task.save
    end
  end

end
