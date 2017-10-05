class User

  def save_token(email, auth_token)
    App::Persistence['email'] = email
    App::Persistence['auth_token'] = auth_token
  end

  def load_username
    App::Persistence['email']
  end

  def load_token
    App::Persistence['auth_token']
  end

  def reset
    App::Persistence['email'] = nil
    App::Persistence['auth_token'] = nil
  end

end
