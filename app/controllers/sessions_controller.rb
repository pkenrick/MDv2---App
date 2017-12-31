class SessionsController < UIViewController

  attr_accessor :logo_view, :continue_button, :continue_text

  def viewDidLoad
    super
    self.title = 'Sample Login'
    # self.view.backgroundColor = UIColor.blueColor

    background_image_view = UIImageView.alloc.initWithFrame(self.view.bounds)
    background_image_view.setImage(UIImage.imageNamed("background.png"))
    background_image_view.alpha = 1
    self.view.addSubview(background_image_view)

    # add logo to the title page
    add_logo

    # add the full screen button to the title page along with the label requesting user touch screen
    add_continue_button
  end

  def add_logo
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
  end

  def add_continue_button
    @continue_button = UIButton.buttonWithType(UIButtonTypeCustom)
    continue_button.frame = self.view.bounds
    continue_button.backgroundColor = UIColor.clearColor
    self.view.addSubview(continue_button)

    @continue_text = UILabel.alloc.init
    continue_text.text = ("Touch to start")
    continue_text.font = UIFont.fontWithName("AmericanTypewriter", size: 15)
    continue_text.sizeToFit
    self.view.addSubview(continue_text)

    continue_text.translatesAutoresizingMaskIntoConstraints = false
    continue_text_top = NSLayoutConstraint.constraintWithItem(continue_text, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: @logo_view, attribute: NSLayoutAttributeBottom, multiplier: 1.0, constant: 40)
    continue_text_left = NSLayoutConstraint.constraintWithItem(continue_text, attribute: NSLayoutAttributeCenterX, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeCenterX, multiplier: 1.0, constant: 0)
    self.view.addConstraint(continue_text_top)
    self.view.addConstraint(continue_text_left)

    # continue_button.addTarget(self, action: "continue_action", forControlEvents: UIControlEventTouchUpInside)
    continue_button.addTarget(self, action: "load_navigation_controller", forControlEvents: UIControlEventTouchUpInside)
  end

  def continue_action
    if @login_form.nil? || !@login_form.isDescendantOfView(self.view)

      # alter subview constraints to make space for login fields
      logo_view_top_new_constraint = NSLayoutConstraint.constraintWithItem(logo_view, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeTop, multiplier: 1.0, constant: self.view.size.height * 0.1)
      logo_view_top_old_constraint = self.view.constraints.select{ |constraint| constraint.firstItem == logo_view && constraint.firstAttribute == NSLayoutAttributeTop }.first
      self.view.removeConstraint(logo_view_top_old_constraint)
      self.view.addConstraint(logo_view_top_new_constraint)

      continue_button.removeFromSuperview
      continue_text.removeFromSuperview

      UIView.animateWithDuration(0.2,
        animations: lambda {
        self.view.layoutIfNeeded
        },
        completion: lambda { |finished|
          # build the login form fields
          login_size = [self.view.size.width, self.view.size.height / 2]
          @login_form ||= LoginFormView.build_login_form([[0,0], login_size])
          @login_form.backgroundColor = UIColor.whiteColor
          @login_form.login_button.addTarget(self, action: "login", forControlEvents: UIControlEventTouchUpInside)
          @login_form.alpha = 0

          @login_form.email.delegate = self
          @login_form.password.delegate = self

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
    disable_login_form
    api_client.token(@login_form.email.text, @login_form.password.text) do |result|
      if result.nil?
        display_message("Connection Problem", "Sorry, there seems to be a problem with this device's connection right now.")
      else
        if result['auth_token']
          user.save_token(@login_form.email.text, result['auth_token'])
          load_navigation_controller
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
    enable_login_form
  end

  def api_client
    @api_client ||= ApiClient.new
  end

  def user
    @current_user ||= User.new
  end

  def textFieldShouldReturn(textfield)
    textfield.resignFirstResponder
    return false
  end

  def disable_login_form
    @login_form.email.enabled = false
    @login_form.email.backgroundColor = UIColor.lightGrayColor
    @login_form.password.enabled = false
    @login_form.password.backgroundColor = UIColor.lightGrayColor
    @login_form.login_button.hidden = true
    @login_form.spinner.startAnimating
  end

  def enable_login_form
    @login_form.email.enabled = true
    @login_form.email.backgroundColor = UIColor.colorWithRed(215.0/255.0, green:240.0/255.0, blue:250.0/255.0, alpha:1.0)
    @login_form.password.enabled = true
    @login_form.password.backgroundColor = UIColor.colorWithRed(215.0/255.0, green:240.0/255.0, blue:250.0/255.0, alpha:1.0)
    @login_form.login_button.hidden = false
    @login_form.spinner.stopAnimating
  end

  def textFieldDidBeginEditing(textfield)
    NSNotificationCenter.defaultCenter.addObserver(self, selector: "keyboard_appeared:", name: UIKeyboardDidShowNotification, object: nil)
    NSNotificationCenter.defaultCenter.addObserver(self, selector: "keyboard_disappeared:", name: UIKeyboardDidHideNotification, object: nil)
  end

  def keyboard_appeared(notification)
    NSNotificationCenter.defaultCenter.removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)

    login_form_top_constraint = self.view.constraints.select{ |constraint| constraint.firstItem == @login_form && constraint.firstAttribute == NSLayoutAttributeTop }.first
    logo_view_top_constraint = self.view.constraints.select{ |constraint| constraint.firstItem == logo_view && constraint.firstAttribute == NSLayoutAttributeTop }.first

    return if login_form_top_constraint.constant < 0

    keyboard_rect_ptr = Pointer.new(CGRect.type)
    notification.userInfo.valueForKey('UIKeyboardFrameEndUserInfoKey').getValue(keyboard_rect_ptr)
    keyboard_rect = keyboard_rect_ptr[0]
    keyboard_height = keyboard_rect.size.height

    login_form_top_constraint.constant -= keyboard_height
    logo_view_top_constraint.constant -= keyboard_height

    logo_view_tag_old_top_constraint = logo_view.constraints.select{ |constraint| constraint.firstItem == logo_view.tag && constraint.firstAttribute == NSLayoutAttributeTop }.first
    logo_view.removeConstraint(logo_view_tag_old_top_constraint)
    logo_view_tag_new_bottom_constraint = NSLayoutConstraint.constraintWithItem(logo_view.tag, attribute: NSLayoutAttributeBottom, relatedBy: NSLayoutRelationEqual, toItem: logo_view, attribute: NSLayoutAttributeBottom, multiplier: 1.0, constant: - logo_view.size.height * 0.1)
    logo_view.addConstraint(logo_view_tag_new_bottom_constraint)

    logo_view_title_old_top_constraint = logo_view.constraints.select{ |constraint| constraint.firstItem == logo_view.title && constraint.firstAttribute == NSLayoutAttributeTop }.first
    logo_view.removeConstraint(logo_view_title_old_top_constraint)
    logo_view_title_new_bottom_constraint = NSLayoutConstraint.constraintWithItem(logo_view.title, attribute: NSLayoutAttributeBottom, relatedBy: NSLayoutRelationEqual, toItem: logo_view.tag, attribute: NSLayoutAttributeTop, multiplier: 1.0, constant: 0)
    logo_view.addConstraint(logo_view_title_new_bottom_constraint)

    UIView.animateWithDuration(0.2,
      animations: lambda {
        self.view.layoutIfNeeded
      }
    )
  end

  def keyboard_disappeared(notification)
    NSNotificationCenter.defaultCenter.removeObserver(self, name: UIKeyboardDidHideNotification, object: nil)

    login_form_top_constraint = self.view.constraints.select{ |constraint| constraint.firstItem == @login_form && constraint.firstAttribute == NSLayoutAttributeTop }.first
    logo_view_top_constraint = self.view.constraints.select{ |constraint| constraint.firstItem == logo_view && constraint.firstAttribute == NSLayoutAttributeTop }.first

    return if login_form_top_constraint.constant > 0

    keyboard_rect_ptr = Pointer.new(CGRect.type)
    notification.userInfo.valueForKey('UIKeyboardFrameEndUserInfoKey').getValue(keyboard_rect_ptr)
    keyboard_rect = keyboard_rect_ptr[0]
    keyboard_height = keyboard_rect.size.height

    login_form_top_constraint.constant += keyboard_height
    logo_view_top_constraint.constant += keyboard_height

    logo_view_tag_old_top_constraint = logo_view.constraints.select{ |constraint| constraint.firstItem == logo_view.tag && constraint.firstAttribute == NSLayoutAttributeBottom }.first
    logo_view.removeConstraint(logo_view_tag_old_top_constraint)
    logo_view_tag_new_bottom_constraint = NSLayoutConstraint.constraintWithItem(logo_view.tag, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: logo_view, attribute: NSLayoutAttributeTop, multiplier: 1.0, constant: logo_view.size.height / 10 * 8)
    logo_view.addConstraint(logo_view_tag_new_bottom_constraint)

    logo_view_title_old_top_constraint = logo_view.constraints.select{ |constraint| constraint.firstItem == logo_view.title && constraint.firstAttribute == NSLayoutAttributeBottom }.first
    logo_view.removeConstraint(logo_view_title_old_top_constraint)
    logo_view_title_new_bottom_constraint = NSLayoutConstraint.constraintWithItem(logo_view.title, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: logo_view, attribute: NSLayoutAttributeTop, multiplier: 1.0, constant: logo_view.size.height / 10 * 5)
    logo_view.addConstraint(logo_view_title_new_bottom_constraint)

    UIView.animateWithDuration(0.2,
      animations: lambda {
        self.view.layoutIfNeeded
      }
    )
  end

  def load_navigation_controller
    # api_client.pull_tasks('private') do |private_api_tasks|
    #   private_task_list_controller = TaskListController.alloc.initWithType('private', Task.where(type: 'private'))
    #   api_client.pull_tasks('shared') do |shared_api_tasks|
    #     shared_task_list_controller = TaskListController.alloc.initWithType('shared', Task.where(type: 'shared'))
    #     settings_controller = UIViewController.alloc.init
    #     private_nav_bar_controller = UINavigationController.alloc.initWithRootViewController(private_task_list_controller)
    #     private_task_list_controller.navigation_controller = private_nav_bar_controller
    #     shared_nav_bar_controller = UINavigationController.alloc.initWithRootViewController(shared_task_list_controller)
    #     shared_task_list_controller.navigation_controller = shared_nav_bar_controller
    #     tab_bar_controller = UITabBarController.alloc.init
    #     tab_bar_controller.viewControllers = [private_nav_bar_controller, settings_controller, shared_nav_bar_controller]
    #     self.presentViewController(tab_bar_controller, animated: true, completion: nil)
    #
    #     settings_controller.tabBarItem = UITabBarItem.alloc.initWithTitle("Settings", image: UIImage.imageNamed("settingsIcon30.png"), tag: 1)
    #   end
    # end

    private_task_list_controller = TaskListController.alloc.initWithType('private', Task.where(type: 'private'))
    shared_task_list_controller = TaskListController.alloc.initWithType('shared', Task.where(type: 'shared'))
    settings_controller = UIViewController.alloc.init
    private_nav_bar_controller = UINavigationController.alloc.initWithRootViewController(private_task_list_controller)
    private_task_list_controller.navigation_controller = private_nav_bar_controller
    shared_nav_bar_controller = UINavigationController.alloc.initWithRootViewController(shared_task_list_controller)
    shared_task_list_controller.navigation_controller = shared_nav_bar_controller
    tab_bar_controller = UITabBarController.alloc.init
    tab_bar_controller.viewControllers = [private_nav_bar_controller, settings_controller, shared_nav_bar_controller]
    self.presentViewController(tab_bar_controller, animated: true, completion: nil)

    settings_controller.tabBarItem = UITabBarItem.alloc.initWithTitle("Settings", image: UIImage.imageNamed("settingsIcon30.png"), tag: 1)

  end

end
