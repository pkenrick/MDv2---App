class AddTaskController < UIViewController

  attr_accessor :parent_controller, :table_view, :date_picker_visible, :title_field, :description_field, :date_picker, :note_field

  def init
    super
    self.navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithTitle('Cancel', style: UIBarButtonItemStylePlain, target: self, action: 'cancel_task')
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle('Save', style: UIBarButtonItemStylePlain, target: self, action: 'save_task')
    @date_picker_visible = false
    self
  end

  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.colorWithRed(215.0/255.0, green:240.0/255.0, blue:250.0/255.0, alpha:1.0)
    self.navigationItem.title = "New Task"
    self.navigationController.navigationBar.setTitleTextAttributes(NSFontAttributeName => UIFont.fontWithName("AmericanTypewriter", size: 20))

    @table_view = UITableView.alloc.initWithFrame(CGRectZero, style: UITableViewStyleGrouped)
    @table_view.backgroundColor = UIColor.colorWithRed(215.0/255.0, green:240.0/255.0, blue:250.0/255.0, alpha:1.0)
    self.view.addSubview(@table_view)
    @table_view.translatesAutoresizingMaskIntoConstraints = false
    table_view_top = NSLayoutConstraint.constraintWithItem(@table_view, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeTopMargin, multiplier: 1.0, constant: 0.0)
    table_view_left = NSLayoutConstraint.constraintWithItem(@table_view, attribute: NSLayoutAttributeLeft, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeLeft, multiplier: 1.0, constant: 0.0)
    table_view_right = NSLayoutConstraint.constraintWithItem(@table_view, attribute: NSLayoutAttributeRight, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeRight, multiplier: 1.0, constant: 0.0)
    table_view_bottom = NSLayoutConstraint.constraintWithItem(@table_view, attribute: NSLayoutAttributeBottom, relatedBy: NSLayoutRelationEqual, toItem: self.view, attribute: NSLayoutAttributeBottomMargin, multiplier: 1.0, constant: 0.0)
    self.view.addConstraint(table_view_top)
    self.view.addConstraint(table_view_left)
    self.view.addConstraint(table_view_right)
    self.view.addConstraint(table_view_bottom)
    @table_view.delegate = self
    @table_view.dataSource = self
    @table_view.sectionHeaderHeight = 30

    gesture_recogizer = UITapGestureRecognizer.alloc.initWithTarget(self, action: "dismiss_keyboard")
    gesture_recogizer.cancelsTouchesInView = false
    self.view.addGestureRecognizer(gesture_recogizer)


    self
  end

  def viewWillAppear(animated)
    super
    add_monkey_owner
  end

  def cancel_task
    self.dismissViewControllerAnimated(true, completion: lambda {})
  end

  def save_task
    puts "===== saving task ======"
    puts "title: #{title_field.text}"
    puts "description: #{description_field.text}"
    puts "date: #{date_picker.date.day}/#{date_picker.date.month}/#{date_picker.date.year}"
    puts "note: #{note_field.text}"
  end

  def date_changed
    table_view.beginUpdates
    row_to_reload = NSIndexPath.indexPathForRow(0, inSection: 1)
    table_view.reloadRowsAtIndexPaths([row_to_reload], withRowAnimation: UITableViewRowAnimationNone)
    table_view.endUpdates
  end

  def add_monkey_owner
    monkey_owner = UIImageView.alloc.initWithImage(UIImage.imageNamed("MonkeyBoy.png"))
    image_size = self.view.frame.size.width / 2
    monkey_owner.frame = [[self.view.frame.size.width / 2 - image_size / 2, self.view.frame.size.height],[image_size, image_size]]
    self.view.addSubview(monkey_owner)

    UIView.animateWithDuration(1,
      animations: lambda {
        monkey_owner.frame = [[self.view.frame.size.width / 2 - image_size / 2, self.view.frame.size.height - image_size / 2],[image_size, image_size]]
      }
    )
  end

  # === UITableView Delegate ====

  def numberOfSectionsInTableView(tableView)
    3
  end

  def tableView(tableView, numberOfRowsInSection: section)
    2
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    if indexPath.section == 1 && indexPath.row == 1
      date_picker_visible == true ? 150 : 0
    elsif indexPath.section == 2 && indexPath.row == 1
      self.view.frame.size.height / 4
    else
      44
    end
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier: reuseIdentifier)

    cell.selectionStyle = UITableViewCellSelectionStyleNone

    section = indexPath.section
    case section
    when 0
      if indexPath.row == 0
        @title_field = UITextField.alloc.initWithFrame([[self.view.frame.size.width * 0.05,0],[self.view.frame.size.width * 0.9, cell.frame.size.height]])
        @title_field.placeholder = 'Title'
        @title_field.setReturnKeyType(UIReturnKeyDone)
        @title_field.delegate = self
        cell.addSubview(@title_field)
      elsif indexPath.row == 1
        @description_field = UITextField.alloc.initWithFrame([[self.view.frame.size.width * 0.05,0],[self.view.frame.size.width * 0.9, cell.frame.size.height]])
        @description_field.placeholder = 'Description'
        @description_field.setReturnKeyType(UIReturnKeyDone)
        @description_field.delegate = self
        cell.addSubview(@description_field)
      end
    when 1
      if indexPath.row == 0
        cell.textLabel.text = 'Due date'
        if date_picker
          date_format = NSDateFormatter.alloc.init.setDateFormat("cccc, MMM d, hh:mm aa")
          cell.detailTextLabel.text = date_format.stringFromDate(date_picker.date)
        else
          cell.detailTextLabel.text = 'Select date'
        end
      elsif indexPath.row == 1
        @date_picker = UIDatePicker.alloc.init
        @date_picker.frame = [[0,0],[self.view.frame.size.width, 150]]
        @date_picker.alpha = date_picker_visible ? 1.0 : 0.0
        @date_picker.addTarget(self, action: 'date_changed', forControlEvents: UIControlEventValueChanged)
        cell.addSubview(@date_picker)
      end
    when 2
      if indexPath.row == 0
        cell.textLabel.text = 'Notes'
      else
        @note_field = UITextView.alloc.initWithFrame([[self.view.frame.size.width * 0.025,0],[self.view.frame.size.width * 0.95, self.view.frame.size.height / 4]])
        @note_field.setFont(UIFont.fontWithName("Helvetica", size: 17))
        @note_field.delegate = self
        cell.addSubview(@note_field)
      end
    end

    # cell.backgroundColor = UIColor.yellowColor

    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    if indexPath.section == 1 && indexPath.row == 0
      @date_picker_visible = !date_picker_visible
      tableView.beginUpdates
      tableView.endUpdates
      UIView.animateWithDuration(0.25, animations: lambda { @date_picker.alpha = (date_picker_visible ? 1.0 : 0.0) })
    end
  end

  # === Keyboard Delegate ====

  def textFieldShouldReturn(textfield)
    textfield.resignFirstResponder
    return false
  end

  def dismiss_keyboard
    self.view.endEditing(true)
  end

  def textViewDidBeginEditing(textfield)
    NSNotificationCenter.defaultCenter.addObserver(self, selector: "keyboard_appeared:", name: UIKeyboardDidShowNotification, object: nil)
    NSNotificationCenter.defaultCenter.addObserver(self, selector: "keyboard_disappeared:", name: UIKeyboardDidHideNotification, object: nil)
  end

  def keyboard_appeared(notification)
    NSNotificationCenter.defaultCenter.removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)

    table_view_top_constraint = self.view.constraints.select{ |constraint| constraint.firstItem == @table_view && constraint.firstAttribute == NSLayoutAttributeTop }.first
    table_view_bottom_constraint = self.view.constraints.select{ |constraint| constraint.firstItem == @table_view && constraint.firstAttribute == NSLayoutAttributeBottom }.first

    return if table_view_top_constraint.constant < 0

    keyboard_rect_ptr = Pointer.new(CGRect.type)
    notification.userInfo.valueForKey('UIKeyboardFrameEndUserInfoKey').getValue(keyboard_rect_ptr)
    keyboard_rect = keyboard_rect_ptr[0]
    keyboard_height = keyboard_rect.size.height

    table_view_top_constraint.constant -= keyboard_height
    table_view_bottom_constraint.constant -= keyboard_height

    UIView.animateWithDuration(0.2,
      animations: lambda {
        self.view.layoutIfNeeded
      }
    )
  end

  def keyboard_disappeared(notification)
    NSNotificationCenter.defaultCenter.removeObserver(self, name: UIKeyboardDidHideNotification, object: nil)

    table_view_top_constraint = self.view.constraints.select{ |constraint| constraint.firstItem == @table_view && constraint.firstAttribute == NSLayoutAttributeTop }.first
    table_view_bottom_constraint = self.view.constraints.select{ |constraint| constraint.firstItem == @table_view && constraint.firstAttribute == NSLayoutAttributeBottom }.first

    return if table_view_top_constraint.constant >= 0

    keyboard_rect_ptr = Pointer.new(CGRect.type)
    notification.userInfo.valueForKey('UIKeyboardFrameEndUserInfoKey').getValue(keyboard_rect_ptr)
    keyboard_rect = keyboard_rect_ptr[0]
    keyboard_height = keyboard_rect.size.height

    table_view_top_constraint.constant += keyboard_height
    table_view_bottom_constraint.constant += keyboard_height

    UIView.animateWithDuration(0.2,
      animations: lambda {
        self.view.layoutIfNeeded
      }
    )
  end

end
