class LoginFormView < UIView

  attr_accessor :email, :password, :login_button, :view_tasks_button, :spinner

  def self.build_login_form(bounds)
    login_form_view = LoginFormView.alloc.initWithFrame(bounds)
    login_form_view.alpha = 0
    login_form_view.build_username
    login_form_view.build_password
    login_form_view.build_login_button
    login_form_view.build_spinner
    login_form_view.build_view_tasks_button
    login_form_view
  end

  def build_username
    @email = UITextField.alloc.init
    @email.font = UIFont.fontWithName("AmericanTypewriter", size: 20)
    @email.placeholder = 'Email Address'
    # @email.text = 'paul@email.com'
    @email.setBorderStyle(UITextBorderStyleNone)
    @email.backgroundColor = UIColor.colorWithRed(215.0/255.0, green:240.0/255.0, blue:250.0/255.0, alpha:1.0)
    @email.returnKeyType = UIReturnKeyDone
    @email.clearButtonMode = UITextFieldViewModeWhileEditing
    @email.autocorrectionType = UITextAutocorrectionTypeNo
    @email.autocapitalizationType = UITextAutocapitalizationTypeNone
    @email.keyboardType = UIKeyboardTypeEmailAddress
    build_spacer(@email)
    @email.delegate = self
    self.addSubview(@email)

    @email.translatesAutoresizingMaskIntoConstraints = false
    email_bottom = NSLayoutConstraint.constraintWithItem(email, attribute: NSLayoutAttributeBottom, relatedBy: NSLayoutRelationEqual, toItem: self, attribute: NSLayoutAttributeCenterY, multiplier: 1.0, constant: - self.size.height * 0.1)
    email_center_x = NSLayoutConstraint.constraintWithItem(email, attribute: NSLayoutAttributeCenterX, relatedBy: NSLayoutRelationEqual, toItem: self, attribute: NSLayoutAttributeCenterX, multiplier: 1.0, constant: 0)
    email_width = NSLayoutConstraint.constraintWithItem(email, attribute: NSLayoutAttributeWidth, relatedBy: NSLayoutRelationEqual, toItem: nil, attribute: 0, multiplier: 0.0, constant: 250)
    email_height = NSLayoutConstraint.constraintWithItem(email, attribute: NSLayoutAttributeHeight, relatedBy: NSLayoutRelationEqual, toItem: nil, attribute: 0, multiplier: 0.0, constant: 60)

    self.addConstraint(email_bottom)
    self.addConstraint(email_center_x)
    self.addConstraint(email_width)
    self.addConstraint(email_height)
  end

  def build_password
    @password = UITextField.alloc.init
    @password.font = UIFont.fontWithName("AmericanTypewriter", size: 20)
    @password.placeholder = 'Password'
    # @password.text = 'helloo'
    @password.secureTextEntry = true
    @password.setBorderStyle(UITextBorderStyleNone)
    @password.backgroundColor = UIColor.colorWithRed(215.0/255.0, green:240.0/255.0, blue:250.0/255.0, alpha:1.0)
    @password.returnKeyType = UIReturnKeyDone
    @password.clearButtonMode = UITextFieldViewModeWhileEditing
    build_spacer(@password)
    @password.delegate = self
    self.addSubview(@password)

    @password.translatesAutoresizingMaskIntoConstraints = false
    password_top = NSLayoutConstraint.constraintWithItem(password, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: email, attribute: NSLayoutAttributeBottom, multiplier: 1.0, constant: self.size.height * 0.1)
    password_center_x = NSLayoutConstraint.constraintWithItem(password, attribute: NSLayoutAttributeCenterX, relatedBy: NSLayoutRelationEqual, toItem: self, attribute: NSLayoutAttributeCenterX, multiplier: 1.0, constant: 0)
    password_width = NSLayoutConstraint.constraintWithItem(password, attribute: NSLayoutAttributeWidth, relatedBy: NSLayoutRelationEqual, toItem: nil, attribute: 0, multiplier: 0.0, constant: 250)
    password_height = NSLayoutConstraint.constraintWithItem(password, attribute: NSLayoutAttributeHeight, relatedBy: NSLayoutRelationEqual, toItem: nil, attribute: 0, multiplier: 0.0, constant: 60)

    self.addConstraint(password_top)
    self.addConstraint(password_center_x)
    self.addConstraint(password_width)
    self.addConstraint(password_height)
  end

  def build_login_button
    @login_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @login_button.setTitle("Log In", forState: UIControlStateNormal)
    @login_button.font = UIFont.fontWithName("AmericanTypewriter", size: 20)
    @login_button.sizeToFit
    self.addSubview(@login_button)

    @login_button.translatesAutoresizingMaskIntoConstraints = false
    login_button_top = NSLayoutConstraint.constraintWithItem(login_button, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: password, attribute: NSLayoutAttributeBottom, multiplier: 1.0, constant: self.size.height * 0.1)
    login_button_left = NSLayoutConstraint.constraintWithItem(login_button, attribute: NSLayoutAttributeLeft, relatedBy: NSLayoutRelationEqual, toItem: self, attribute: NSLayoutAttributeCenterX, multiplier: 1.0, constant: @login_button.size.width / -2)

    self.addConstraint(login_button_top)
    self.addConstraint(login_button_left)
  end

  def build_spinner
    @spinner = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleWhiteLarge)
    spinner.color = UIColor.colorWithRed(110.0/255.0, green:200.0/255.0, blue:255.0/255.0, alpha:1.0)
    spinner.sizeToFit
    self.addSubview(spinner)

    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner_center_y = NSLayoutConstraint.constraintWithItem(spinner, attribute: NSLayoutAttributeCenterY, relatedBy: NSLayoutRelationEqual, toItem: @login_button, attribute: NSLayoutAttributeCenterY, multiplier: 1.0, constant: 0)
    spinner_center_x = NSLayoutConstraint.constraintWithItem(spinner, attribute: NSLayoutAttributeCenterX, relatedBy: NSLayoutRelationEqual, toItem: @login_button, attribute: NSLayoutAttributeCenterX, multiplier: 1.0, constant: 0)

    self.addConstraint(spinner_center_y)
    self.addConstraint(spinner_center_x)
  end

  def build_view_tasks_button
    @view_tasks_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @view_tasks_button.frame = [[20, 350], [325, 40]]
    @view_tasks_button.setTitle("View Tasks", forState: UIControlStateNormal)
    # addSubview @view_tasks_button
  end

  def build_spacer(textfield)
    spacer = UIView.alloc.initWithFrame(CGRectMake(0,0,10,10))
    textfield.setLeftViewMode(UITextFieldViewModeAlways)
    textfield.setLeftView(spacer)
  end

  # def textFieldShouldReturn(textfield)
  #   textfield.resignFirstResponder
  #   return false
  # end
  #
  # def disable_form
  #   email.enabled = false
  #   email.backgroundColor = UIColor.lightGrayColor
  #   password.enabled = false
  #   password.backgroundColor = UIColor.lightGrayColor
  #   login_button.hidden = true
  #   spinner.startAnimating
  # end
  #
  # def enable_form
  #   email.enabled = true
  #   email.backgroundColor = UIColor.colorWithRed(215.0/255.0, green:240.0/255.0, blue:250.0/255.0, alpha:1.0)
  #   password.enabled = true
  #   password.backgroundColor = UIColor.colorWithRed(215.0/255.0, green:240.0/255.0, blue:250.0/255.0, alpha:1.0)
  #   login_button.hidden = false
  #   spinner.stopAnimating
  # end

end
