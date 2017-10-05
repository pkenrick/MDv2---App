class SessionsController < UIViewController

  def viewDidLoad
    super
    self.title = 'Sample Login'
    self.view.backgroundColor = UIColor.blueColor


    @login_form = LoginFormView.build_login_form
    @login_form.login_button.addTarget(self, action: "login", forControlEvents: UIControlEventTouchUpInside)
    self.view.addSubview(@login_form)
  end

  def login
    api_client.token(@login_form.username.text, @login_form.password.text) do |result|
      if result['auth_token']
        user.save_token(@login_form.username.text, result['auth_token'])
        display_message("Welcome", "Welcome, #{@login_form.username.text}")
        show_view_tasks_button
      else
        display_message("Error", "Invalid Credentials.")
      end
    end
  end

  def display_message(title, message)
    alert_box = UIAlertView.alloc.initWithTitle(title, message: message, delegate: nil, cancelButtonTitle: 'OK', otherButtonTitles: nil)
    alert_box.show
  end

  def api_client
    @api_client ||= ApiClient.new
  end

  def user
    @current_user ||= User.new
  end

  def show_view_tasks_button
    @login_form.addSubview(@login_form.view_tasks_button)
    @login_form.view_tasks_button.addTarget(self, action: "show_tasks", forControlEvents: UIControlEventTouchUpInside)
  end

  def show_tasks
    api_client.get_tasks
  end

end
