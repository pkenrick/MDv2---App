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
      block.call(result.object)
    end
  end

end
