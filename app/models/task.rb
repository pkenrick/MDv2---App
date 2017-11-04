class Task < CDQManagedObject

  def self.pull_tasks_for_list_type(type, &block)
    self.api_client.pull_tasks(type) do |api_tasks|
      api_tasks['tasks'].each do |task|
        cd_tasks = Task.where(api_id: task[:id])
        if cd_tasks.any?
          cd_task = cd_tasks.first
          cd_task.title = task[:title]
          cd_task.details = task[:description]
          # cd_task.due_date = task[:due_date]
          cd_task.complete = task[:complete?]
        else
          Task.create(api_id: task[:id], title: task[:title], details: task[:description], complete: task[:complete?])
          Task.save

        end
        block.call
      end
    end
  end

  def self.api_client
    @api_client ||= ApiClient.new
  end

end
