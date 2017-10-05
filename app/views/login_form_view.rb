class LoginFormView < UIView

  attr_accessor :username, :password, :login_button, :view_tasks_button

  def self.build_login_form
    login_form_view = LoginFormView.alloc.initWithFrame(CGRectMake(10,10,500,500))
    login_form_view.build_username
    login_form_view.build_password
    login_form_view.build_login_button
    login_form_view.build_view_tasks_button
    login_form_view
  end

  def build_username
    @username = UITextField.alloc.initWithFrame([[20, 150], [325, 40]])
    @username.placeholder = 'username'
    @username.text = 'paul@email.com'
    @username.setBorderStyle(UITextBorderStyleRoundedRect)
    self.addSubview(@username)
  end

  def build_password
    @password = UITextField.alloc.initWithFrame([[20, 200], [325, 40]])
    @password.placeholder = 'password'
    @password.text = 'helloo'
    @password.secureTextEntry = true
    @password.setBorderStyle UITextBorderStyleRoundedRect
    self.addSubview @password
  end

  def build_login_button
    @login_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @login_button.frame = [[20, 250], [325, 40]]
    @login_button.setTitle("login", forState: UIControlStateNormal)
    self.addSubview @login_button
  end

  def build_view_tasks_button
    @view_tasks_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @view_tasks_button.frame = [[20, 350], [325, 40]]
    @view_tasks_button.setTitle("View Tasks", forState: UIControlStateNormal)
    # addSubview @view_tasks_button
  end

end
