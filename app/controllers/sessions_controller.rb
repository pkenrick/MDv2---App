class SessionsController < UIViewController

  attr_accessor :logo_view, :continue_button

  def viewDidLoad
    super
    self.title = 'Sample Login'
    self.view.backgroundColor = UIColor.blueColor

    # add logo to the title page
    logo_size = [self.view.size.height / 2, self.view.size.height / 3]
    @logo_view = LogoView.build_logo([[0,0], logo_size])
    self.view.addSubview(@logo_view)

    @logo_view.translatesAutoresizingMaskIntoConstraints = false
    logo_view_top = NSLayoutConstraint.constraintWithItem(logo_view, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeCenterY, multiplier: 1.0, constant: - self.view.size.height * 0.4 / 2)
    logo_view_left = NSLayoutConstraint.constraintWithItem(logo_view, attribute: NSLayoutAttributeLeft, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeLeft, multiplier: 1.0, constant: self.view.size.width * 0.1)
    logo_view_width = NSLayoutConstraint.constraintWithItem(logo_view, attribute: NSLayoutAttributeWidth, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeWidth, multiplier: 0.8, constant: 0)
    logo_view_height = NSLayoutConstraint.constraintWithItem(logo_view, attribute: NSLayoutAttributeHeight, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeHeight, multiplier: 0.4, constant: 0)
    self.view.addConstraint(logo_view_top)
    self.view.addConstraint(logo_view_left)
    self.view.addConstraint(logo_view_width)
    self.view.addConstraint(logo_view_height)

    # add the full screen button to the title page along with the label requesting user touch screen
    @continue_button = UIButton.buttonWithType(UIButtonTypeCustom)
    continue_button.frame = self.view.bounds
    continue_button.backgroundColor = UIColor.clearColor
    self.view.addSubview(continue_button)

    continue_text = UILabel.alloc.init
    continue_text.text = ("Touch to start")
    continue_text.font = UIFont.fontWithName("AmericanTypewriter", size: 15)
    continue_text.sizeToFit
    self.view.addSubview(continue_text)

    continue_text.translatesAutoresizingMaskIntoConstraints = false
    continue_text_top = NSLayoutConstraint.constraintWithItem(continue_text, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: @logo_view, attribute: NSLayoutAttributeBottom, multiplier: 1.0, constant: 40)
    continue_text_left = NSLayoutConstraint.constraintWithItem(continue_text, attribute: NSLayoutAttributeCenterX, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeCenterX, multiplier: 1.0, constant: 0)
    self.view.addConstraint(continue_text_top)
    self.view.addConstraint(continue_text_left)

    continue_button.addTarget(self, action: "continue_action", forControlEvents: UIControlEventTouchUpInside)
  end

  def continue_action
    if @login_form.nil? || !@login_form.isDescendantOfView(self.view)
      # alter subview constraints to make space for login fields
      logo_view_top = NSLayoutConstraint.constraintWithItem(logo_view, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeTop, multiplier: 1.0, constant: self.view.size.height * 0.1)
      logo_view_left = NSLayoutConstraint.constraintWithItem(logo_view, attribute: NSLayoutAttributeLeft, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeLeft, multiplier: 1.0, constant: self.view.size.width * 0.1)
      logo_view_width = NSLayoutConstraint.constraintWithItem(logo_view, attribute: NSLayoutAttributeWidth, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeWidth, multiplier: 0.8, constant: 0)
      logo_view_height = NSLayoutConstraint.constraintWithItem(logo_view, attribute: NSLayoutAttributeHeight, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeHeight, multiplier: 0.4, constant: 0)
      self.view.addConstraint(logo_view_top)
      self.view.addConstraint(logo_view_left)
      self.view.addConstraint(logo_view_width)
      self.view.addConstraint(logo_view_height)

      continue_button.removeFromSuperview

      UIView.animateWithDuration(0.2,
        animations: lambda {
        self.view.layoutIfNeeded
        # @login_form.alpha = 1
        },
        completion: lambda { |finished|
          # build the login form fields
          login_size = [self.view.size.width, self.view.size.height / 2]
          @login_form ||= LoginFormView.build_login_form([[0,0], login_size])
          @login_form.backgroundColor = UIColor.whiteColor
          @login_form.login_button.addTarget(self, action: "login", forControlEvents: UIControlEventTouchUpInside)
          @login_form.alpha = 0

          @login_form.email.delegate = self
          @login_form.email.delegate = self

          self.view.addSubview(@login_form)

          @login_form.translatesAutoresizingMaskIntoConstraints = false
          login_form_top = NSLayoutConstraint.constraintWithItem(@login_form, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeCenterY, multiplier: 1.0, constant: 0)
          login_form_left = NSLayoutConstraint.constraintWithItem(@login_form, attribute: NSLayoutAttributeLeft, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeLeft, multiplier: 1.0, constant: 0)
          login_form_width = NSLayoutConstraint.constraintWithItem(@login_form, attribute: NSLayoutAttributeWidth, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeWidth, multiplier: 1.0, constant: 0)
          login_form_height = NSLayoutConstraint.constraintWithItem(@login_form, attribute: NSLayoutAttributeHeight, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeHeight, multiplier: 0.5, constant: 0)
          self.view.addConstraint(login_form_top)
          self.view.addConstraint(login_form_left)
          self.view.addConstraint(login_form_width)
          self.view.addConstraint(login_form_height)

          # effect the changes with animation
          UIView.animateWithDuration(0.2, animations: lambda {
            @login_form.alpha = 1
            })
        })

      # self.view.layoutIfNeeded


    else
      # alter button constraints to back to original
      continue_button_top = NSLayoutConstraint.constraintWithItem(continue_button, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: @logo_view, attribute: NSLayoutAttributeBottom, multiplier: 1.0, constant: 40)
      self.view.addConstraint(continue_button_top)
      # remove the login form fields from the parent view
      @login_form.removeFromSuperview
      # effect the changes with animation
      UIView.animateWithDuration(0.5, animations: lambda {
        self.view.layoutIfNeeded
        @login_form.alpha = 0
        })
    end


  end

  def login
    @login_form.disable_form
    api_client.token(@login_form.email.text, @login_form.password.text) do |result|
      if result.nil?
        display_message("Connection Problem", "Sorry, there seems to be a problem with this device's connectin right now.")
      else
        if result['auth_token']
          user.save_token(@login_form.email.text, result['auth_token'])
          display_message("Welcome", "Welcome, #{@login_form.email.text}")
          # show_view_tasks_button
        else
          display_message("Error", "Invalid Credentials.")
        end
      end
    end
  end

  def display_message(title, message)
    alert_box = UIAlertView.alloc.initWithTitle(title, message: message, delegate: self, cancelButtonTitle: 'OK', otherButtonTitles: nil)
    alert_box.show
  end

  def alertView(alert_box, clickedButtonAtIndex: button_index)
    @login_form.enable_form
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

  def textFieldShouldReturn(textfield)
    textfield.resignFirstResponder
    return false
  end

  def disable_form
    email.enabled = false
    email.backgroundColor = UIColor.lightGrayColor
    password.enabled = false
    password.backgroundColor = UIColor.lightGrayColor
    login_button.hidden = true
    spinner.startAnimating
  end

  def enable_form
    email.enabled = true
    email.backgroundColor = UIColor.colorWithRed(215.0/255.0, green:240.0/255.0, blue:250.0/255.0, alpha:1.0)
    password.enabled = true
    password.backgroundColor = UIColor.colorWithRed(215.0/255.0, green:240.0/255.0, blue:250.0/255.0, alpha:1.0)
    login_button.hidden = false
    spinner.stopAnimating
  end

  def textFieldDidBeginEditing(textfield)
    NSNotificationCenter.defaultCenter.addObserver(self, selector: "keyboard_appeared:", name: UIKeyboardDidShowNotification, object: nil)
    NSNotificationCenter.defaultCenter.addObserver(self, selector: "keyboard_disappeared:", name: UIKeyboardDidHideNotification, object: nil)
  end

  def keyboard_appeared(notification)
    puts "keyboard_appeared"
    NSNotificationCenter.defaultCenter.removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)

    keyboard_rect_ptr = Pointer.new(CGRect.type)
    notification.userInfo.valueForKey('UIKeyboardFrameEndUserInfoKey').getValue(keyboard_rect_ptr)
    keyboard_rect = keyboard_rect_ptr[0]
    keyboard_height = keyboard_rect.size.height

    login_form_top = NSLayoutConstraint.constraintWithItem(@login_form, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeCenterY, multiplier: 1.0, constant: -keyboard_height)
    self.view.addConstraint(login_form_top)
    UIView.animateWithDuration(0.2,
      animations: lambda {
        self.view.layoutIfNeeded
      }
    )
  end

  def keyboard_disappeared(notification)
    puts "keyboard_disappeared"
    NSNotificationCenter.defaultCenter.removeObserver(self, name: UIKeyboardDidHideNotification, object: nil)

    keyboard_rect_ptr = Pointer.new(CGRect.type)
    notification.userInfo.valueForKey('UIKeyboardFrameEndUserInfoKey').getValue(keyboard_rect_ptr)
    keyboard_rect = keyboard_rect_ptr[0]
    keyboard_height = keyboard_rect.size.height

    puts @login_form

    login_form_top = NSLayoutConstraint.constraintWithItem(@login_form, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeCenterY, multiplier: 1.0, constant: 0)
    self.view.addConstraint(login_form_top)
    UIView.animateWithDuration(0.2,
      animations: lambda {
        self.view.layoutIfNeeded
      }
    )
  end

end
