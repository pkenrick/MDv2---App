class TaskListController < UIViewController

  attr_accessor :type

  def initWithType(type)
    self.init
    @type = type
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("#{type.capitalize} List", image: UIImage.imageNamed("monkeyIcon.png"), tag: 1)
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
  end

  def tableView(tableView, numberOfSectionsInTableView: tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection: section)
    3
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: reuseIdentifier)

    cell.textLabel.text = ['Task1', 'Task2', 'Task3'][indexPath.row]
    # cell.imageView.image = UIImage.imageNamed("Checkbox-complete.png")

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator

    cell
  end

end
