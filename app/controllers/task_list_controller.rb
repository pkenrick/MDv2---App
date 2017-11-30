class TaskListController < UIViewController

  attr_accessor :type, :table_view, :tasks

  def initWithType(type, tasks)
    self.init
    @type = type
    @tasks = tasks

    tab_image = @type == 'private' ? "monkeyIcon.png" : "monkeyIconDouble.png"
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("#{type.capitalize} List", image: UIImage.imageNamed(tab_image), tag: 1)

    add_task_button = UIButton.buttonWithType(UIButtonTypeCustom)
    add_task_button.addTarget(self, action: 'add_task', forControlEvents: UIControlEventTouchUpInside)
    add_task_button.setImage(UIImage.imageNamed('grey_circle_large_plus_small.png'), forState: UIControlStateNormal)
    add_task_bar_button = UIBarButtonItem.alloc.initWithCustomView(add_task_button)
    self.navigationItem.rightBarButtonItem = add_task_bar_button

    self
  end

  def viewDidLoad
    self.view.backgroundColor = UIColor.whiteColor

    self.navigationItem.title = "#{type.capitalize} List"
    self.navigationController.navigationBar.setTitleTextAttributes(NSFontAttributeName => UIFont.fontWithName("AmericanTypewriter", size: 20))
    create_table_view
  end

  def create_table_view
    @table_view = UITableView.alloc.init
    @table_view.separatorStyle = UITableViewCellSeparatorStyleNone
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

    header_view = UIView.alloc.init
    header_view.backgroundColor = UIColor.colorWithRed(247.0/255.0, green:247.0/255.0, blue:247.0/255.0, alpha:1.0)
    header_view.frame = [header_view.frame.origin, [self.view.frame.size.width, self.view.frame.size.height / 6]]
    @table_view.tableHeaderView = header_view

    # paragraph_rect = CGRect.new
    # cg_size = CGSizeMake(self.view.frame.size.width, 1000)
    # text = NSMutableAttributedString.alloc.initWithString('Only you have access to the tasks on this list.')
    # rect = text.boundingRectWithSize(cg_size, options: (NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading), context: nil)

    lay_out_table_header_view(header_view)
  end

  def add_task
    add_task_controller = AddTaskController.alloc.initWithType('private')
    add_task_controller.parent_controller = self
    add_task_navigation_controller = UINavigationController.alloc.initWithRootViewController(add_task_controller)
    self.presentViewController(add_task_navigation_controller, animated: true, completion: lambda {})
  end














  def lay_out_table_header_view(header_view)
    description_label = UILabel.alloc.initWithFrame([[self.view.frame.size.width * 0.1 / 2,0],[self.view.frame.size.width * 0.9, header_view.frame.size.height / 3]])
    description_label.text = 'Only you have access to the tasks on this list' if type == 'private'
    description_label.text = 'Both you and your partner have access to these tasks' if type == 'shared'
    description_label.textColor = UIColor.grayColor
    description_label.numberOfLines = 1
    description_label.adjustsFontSizeToFitWidth = true
    description_label.textAlignment = NSTextAlignmentCenter
    header_view.addSubview(description_label)

    horizontal_line_1 = UIView.alloc.init
    horizontal_line_1.backgroundColor = UIColor.colorWithRed(224.0/255.0, green:224.0/255.0, blue:224.0/255.0, alpha:1.0)
    horizontal_line_1.frame = [[0, description_label.frame.size.height],[self.view.frame.size.width, 1]]
    header_view.addSubview(horizontal_line_1)

    vertical_line_1 = UIView.alloc.init
    vertical_line_1.backgroundColor = UIColor.colorWithRed(224.0/255.0, green:224.0/255.0, blue:224.0/255.0, alpha:1.0)
    vertical_line_1.frame = [[self.view.frame.size.width / 2, description_label.frame.size.height + 1],[1, header_view.frame.size.height - description_label.frame.size.height - 2]]
    header_view.addSubview(vertical_line_1)

    horizontal_line_2 = UIView.alloc.init
    horizontal_line_2.backgroundColor = UIColor.colorWithRed(224.0/255.0, green:224.0/255.0, blue:224.0/255.0, alpha:1.0)
    horizontal_line_2.frame = [[0, header_view.frame.size.height - 1],[self.view.frame.size.width, 1]]
    header_view.addSubview(horizontal_line_2)

    total_tasks_view = UILabel.alloc.init
    total_tasks_view.frame = [[self.view.frame.size.width / 2 / 3 / 2,(header_view.frame.size.height + description_label.frame.size.height) / 3],[self.view.frame.size.width / 2 / 3 * 2, (header_view.frame.size.height - description_label.frame.size.height) / 3 * 2]]
    header_view.addSubview(total_tasks_view)

    total_tasks_label = UILabel.alloc.initWithFrame([[0,0],[total_tasks_view.frame.size.width / 3 * 2, total_tasks_view.frame.size.height]])
    total_tasks_label.text = 'Total Tasks'
    total_tasks_label.font = UIFont.fontWithName("AmericanTypewriter", size: 30)
    total_tasks_label.textColor = UIColor.grayColor
    total_tasks_label.numberOfLines = 2
    total_tasks_label.adjustsFontSizeToFitWidth = true
    total_tasks_label.textAlignment = NSTextAlignmentCenter
    total_tasks_view.addSubview(total_tasks_label)

    total_tasks_number = UILabel.alloc.initWithFrame([[total_tasks_label.frame.size.width,0],[total_tasks_view.frame.size.width / 3 * 1, total_tasks_view.frame.size.height]])
    total_tasks_number.text = tasks.length.to_s
    total_tasks_number.font = UIFont.fontWithName("Chalkduster", size: 30)
    total_tasks_number.textColor = UIColor.grayColor
    total_tasks_number.numberOfLines = 1
    total_tasks_number.adjustsFontSizeToFitWidth = true
    total_tasks_number.textAlignment = NSTextAlignmentCenter
    total_tasks_view.addSubview(total_tasks_number)

    due_today_view = UILabel.alloc.init
    due_today_view.frame = [[(self.view.frame.size.width / 2) + (self.view.frame.size.width / 2 / 3 / 2),(header_view.frame.size.height + description_label.frame.size.height) / 3],[self.view.frame.size.width / 2 / 3 * 2, (header_view.frame.size.height - description_label.frame.size.height) / 3 * 2]]
    header_view.addSubview(due_today_view)

    due_today_label = UILabel.alloc.initWithFrame([[0,0],[due_today_view.frame.size.width / 3 * 2, due_today_view.frame.size.height]])
    due_today_label.text = 'Due Today'
    due_today_label.font = UIFont.fontWithName("AmericanTypewriter", size: 30)
    due_today_label.textColor = UIColor.grayColor
    due_today_label.numberOfLines = 2
    due_today_label.adjustsFontSizeToFitWidth = true
    due_today_label.textAlignment = NSTextAlignmentCenter
    due_today_view.addSubview(due_today_label)

    due_total_number = UILabel.alloc.initWithFrame([[due_today_label.frame.size.width,0],[due_today_view.frame.size.width / 3 * 1, due_today_view.frame.size.height]])
    no_of_tasks_due_today = 0
    tasks.each do |task|
      next if task.due_date.nil?
      todays_date = NSDate.new
      if task.due_date.day == todays_date.day && task.due_date.month == todays_date.month && task.due_date.year == todays_date.year
        no_of_tasks_due_today += 1
      end
    end
    due_total_number.text = no_of_tasks_due_today.to_s
    due_total_number.font = UIFont.fontWithName("Chalkduster", size: 30)
    due_total_number.textColor = UIColor.grayColor
    due_total_number.numberOfLines = 1
    due_total_number.adjustsFontSizeToFitWidth = true
    due_total_number.textAlignment = NSTextAlignmentCenter
    due_today_view.addSubview(due_total_number)
  end


  # === UITableView Delegate ====

  def tableView(tableView, numberOfSectionsInTableView: tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @tasks.count
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    height = self.view.frame.size.height / 10 + 4
    height += 2 if indexPath.row == 0 || indexPath.row == (@tasks.count - 1)
    height
    # self.view.frame.size.height / 10 + 4
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)
    cell ||= CustomCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: reuseIdentifier)

    cell.selectionStyle = UITableViewCellSelectionStyleNone

    cell.title_label.text = tasks[indexPath.row].title

    # cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator

    if indexPath.row == 0
      cell.container_view.frame = [[10, 4],[self.view.frame.size.width - 20, self.view.frame.size.height / 10]]
    elsif indexPath.row == @tasks.count - 1
      cell.container_view.frame = [[10, 2],[self.view.frame.size.width - 20, self.view.frame.size.height / 10]]
    else
      cell.container_view.frame = [[10, 2],[self.view.frame.size.width - 20, self.view.frame.size.height / 10]]
    end

    # cell.container_view.frame = [[10, 2], [self.view.frame.size.width - 20, self.view.frame.size.height / 10]]

    if tasks[indexPath.row].complete == 1
      cell.image_view.image = UIImage.imageNamed("blue_circle_tick.png")
    else
      cell.image_view.image = UIImage.imageNamed("blue_circle_empty.png")
    end

    unless tasks[indexPath.row].due_date.nil?
      cell.date_label.text = "Due: #{tasks[indexPath.row].due_date.day}-#{tasks[indexPath.row].due_date.month}-#{tasks[indexPath.row].due_date.year}"
    end

    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    cell = tableView.cellForRowAtIndexPath(indexPath)
    cell.container_view.layer.borderWidth = 5
  end

  def tableView(tableView, didDeselectRowAtIndexPath: indexPath)
    cell = tableView.cellForRowAtIndexPath(indexPath)
    cell.container_view.layer.borderWidth = 1
  end



end
