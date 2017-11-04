class TaskListController < UIViewController

  attr_accessor :type, :tasks

  def initWithType(type, tasks)
    self.init
    @type = type
    @tasks = tasks
    tab_image = @type == 'private' ? "monkeyIcon.png" : "monkeyIconDouble.png"
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("#{type.capitalize} List", image: UIImage.imageNamed(tab_image), tag: 1)
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

    description_label = UILabel.alloc.initWithFrame([[0,0],[self.view.frame.size.width, header_view.frame.size.height / 3]])
    description_label.text = ' Only you have access to the tasks on this list ' if type == 'private'
    description_label.text = ' Both you and your partner have access to these tasks ' if type == 'shared'
    description_label.numberOfLines = 1
    description_label.adjustsFontSizeToFitWidth = true
    description_label.textAlignment = NSTextAlignmentCenter;
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

    # description_label.font = UIFont.fontWithName("AmericanTypewriter", size: 50)


  end

















  # === UITableView Delegate ====

  def tableView(tableView, numberOfSectionsInTableView: tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @tasks.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: reuseIdentifier)

    cell.textLabel.text = tasks[indexPath.row][:title]
    # cell.imageView.image = UIImage.imageNamed("Checkbox-complete.png")

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator

    cell
  end

end
