class TaskListController < UIViewController

  attr_accessor :type, :table_view, :tasks, :navigation_controller, :reorder_button

  def initWithType(type, tasks)
    self.init
    @type = type
    @tasks = Task.where(type: type).sort_by{ |task| [task.complete, task.app_list_position] }

    tab_image = @type == 'private' ? "monkeyIcon.png" : "monkeyIconDouble.png"
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("#{type.capitalize} List", image: UIImage.imageNamed(tab_image), tag: 1)

    add_task_button = UIButton.buttonWithType(UIButtonTypeCustom)
    add_task_button.addTarget(self, action: 'add_task', forControlEvents: UIControlEventTouchUpInside)
    add_task_button.setImage(UIImage.imageNamed('grey_circle_large_plus_32.png'), forState: UIControlStateNormal)
    add_task_bar_button = UIBarButtonItem.alloc.initWithCustomView(add_task_button)
    self.navigationItem.rightBarButtonItems = [add_task_bar_button]

    @reorder_button = UIButton.buttonWithType(UIButtonTypeCustom)
    @reorder_button.addTarget(self, action: 'reorder_list', forControlEvents: UIControlEventTouchUpInside)
    @reorder_button.setImage(UIImage.imageNamed('arrows_32.png'), forState: UIControlStateNormal)
    reorder_bar_button = UIBarButtonItem.alloc.initWithCustomView(@reorder_button)
    self.navigationItem.leftBarButtonItems = [reorder_bar_button]

    # edit_button = UIBarButtonItem.alloc.initWithTitle('Edit', style: UIBarButtonItemStylePlain, target: self, action: 'edit_list')
    # edit_button.tintColor = UIColor.grayColor

    self
  end

  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.whiteColor

    background_image_view = UIImageView.alloc.initWithFrame(self.view.bounds)
    background_image_view.setImage(UIImage.imageNamed("background.png"))
    background_image_view.alpha = 0.5
    self.view.addSubview(background_image_view)

    self.navigationItem.title = "#{type.capitalize} List"
    navigation_controller.navigationBar.setTitleTextAttributes(NSFontAttributeName => UIFont.fontWithName("AmericanTypewriter", size: 20))

    create_table_view
  end

  def create_table_view
    @table_view = UITableView.alloc.init
    @table_view.separatorStyle = UITableViewCellSeparatorStyleNone
    # @table_view.backgroundColor = UIColor.colorWithRed(215.0/255.0, green:240.0/255.0, blue:250.0/255.0, alpha:1.0)
    @table_view.backgroundColor = UIColor.clearColor

    # table_view.setEditing(true, animated: true)
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
    total_tasks_number.tag = 1
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
    count_tasks_due_today(due_total_number)
    due_total_number.font = UIFont.fontWithName("Chalkduster", size: 30)
    due_total_number.textColor = UIColor.grayColor
    due_total_number.numberOfLines = 1
    due_total_number.adjustsFontSizeToFitWidth = true
    due_total_number.textAlignment = NSTextAlignmentCenter
    due_total_number.tag = 2
    due_today_view.addSubview(due_total_number)
  end

  def count_total_tasks
    total_tasks_number = self.table_view.tableHeaderView.viewWithTag(1)
    total_tasks_number.text = tasks.length.to_s
  end

  def count_tasks_due_today(number_field = nil)
    if number_field
      due_total_number = number_field
    else
      due_total_number = self.table_view.tableHeaderView.viewWithTag(2)
    end
    no_of_tasks_due_today = 0
    tasks.each do |task|
      next if task.due_date.nil?
      todays_date = NSDate.new
      if task.due_date.day == todays_date.day && task.due_date.month == todays_date.month && task.due_date.year == todays_date.year
        no_of_tasks_due_today += 1
      end
    end
    due_total_number.text = no_of_tasks_due_today.to_s
  end

  def reorder_list
    if table_view.isEditing == false
      table_view.setEditing(true, animated: true)
      reorder_button.setImage(UIImage.imageNamed('pink_arrows_32.png'), forState: UIControlStateNormal)
    else
      table_view.setEditing(false, animated: true)
      reorder_button.setImage(UIImage.imageNamed('arrows_32.png'), forState: UIControlStateNormal)
    end
  end

  def complete_task(sender)
    complete_tasks = @tasks.select{ |t| t.complete == 1 }
    saved_tasks = Task.where(type: type)

    task = @tasks.select{ |task| task.complete ==  0 && task.app_list_position == sender.tag }.first

    saved_task = saved_tasks.where(complete: 0, app_list_position: sender.tag).first

    task.complete = true
    task.app_list_position = complete_tasks.count

    saved_task.complete = true
    saved_task.app_list_position = complete_tasks.count

    incomplete_tasks = @tasks.select{ |t| t.complete == 0 }
    incomplete_tasks.each do |incomplete_task|
    end
    ((sender.tag)..(incomplete_tasks.length - 1)).each do |app_list_position|
      current_task = saved_tasks.where(complete: 0, app_list_position: app_list_position + 1).first
      current_task.app_list_position = app_list_position
    end

    Task.save
    table_view.reloadData
  end

  def uncomplete_task(sender)
    incomplete_tasks = @tasks.select{ |t| t.complete == 0 }
    saved_tasks = Task.where(type: type)

    task = @tasks.select{ |task| task.complete ==  1 && task.app_list_position == sender.tag }.first

    saved_task = saved_tasks.where(complete: 1, app_list_position: sender.tag).first

    task.complete = false
    task.app_list_position = incomplete_tasks.count

    saved_task.complete = false
    saved_task.app_list_position = incomplete_tasks.count

    complete_tasks = @tasks.select{ |t| t.complete == 1 }
    ((sender.tag)..(complete_tasks.length - 1)).each do |app_list_position|
      current_task = saved_tasks.where(complete: 1, app_list_position: app_list_position + 1).first
      current_task.app_list_position = app_list_position
    end

    Task.save
    table_view.reloadData
  end

  def delete_task(section, row)
    if section == 0
      tasks = @tasks.select{ |task| task.complete == 0 }
    elsif
      tasks = @tasks.select{ |task| task.complete == 1 }
    end

    task = tasks.select{ |t| t.app_list_position == row }.first
    array_position = @tasks.index(task)
    @tasks.delete_at(array_position)
    tasks.delete(task)
    table_view.reloadData

    if section == 0
      saved_tasks = Task.where(type: type, complete: 0)
    elsif
      saved_tasks = Task.where(type: type, complete: 1)
    end

    seleted_task = saved_tasks.where(app_list_position: row).first
    seleted_task.destroy

    (row..tasks.length - 1).each do |current_row|
      current_task = saved_tasks.where(app_list_position: current_row + 1).first
      current_task.app_list_position = current_row
    end
    Task.save

    count_total_tasks
    count_tasks_due_today
  end


  # === UITableView Delegate ====

  def numberOfSectionsInTableView(table_view)
    2
  end

  def tableView(tableView, numberOfRowsInSection: section)
    if section == 0
      @tasks.select{ |task| task.complete == 0 }.count
    elsif section == 1
      @tasks.select{ |task| task.complete == 1 }.count
    end
  end

  def tableView(tableView, titleForHeaderInSection: section)
    if section == 0
      @tasks.select{ |task| task.complete == 0 }.any? ? "--- Incomplete ---" : nil
    elsif section == 1
      @tasks.select{ |task| task.complete == 1 }.any? ? "--- Complete ---" : nil
    end
  end

  def tableView(tableView, viewForHeaderInSection: section)
    section_header_view = UILabel.alloc.init
    if section == 0
      section_header_view.text = "--- Incomplete Tasks ---"
    elsif section == 1
      section_header_view.text = "--- Complete Tasks ---"
    end
    section_header_view.backgroundColor = UIColor.clearColor
    section_header_view.textColor = UIColor.lightGrayColor
    section_header_view.textAlignment = UITextAlignmentCenter
    return section_header_view
  end

  def tableView(tableView, heightForHeaderInSection: section)
    return self.view.frame.size.height / 20
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    if indexPath.section == 0
      tasks = @tasks.select{ |task| task.complete == 0 }
    elsif indexPath.section == 1
      tasks = @tasks.select{ |task| task.complete == 1 }
    end

    height = self.view.frame.size.height / 10 + 4
    height += 2 if indexPath.row == 0
    height += 2 if indexPath.row == (tasks.count - 1)
    height
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)
    cell ||= CustomCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: reuseIdentifier)

    cell.selectionStyle = UITableViewCellSelectionStyleNone

    if indexPath.section == 0
      tasks_for_section = tasks.select{ |task| task.complete == 0 }
    elsif indexPath.section == 1
      tasks_for_section = tasks.select{ |task| task.complete == 1 }
    end
    current_task = tasks_for_section.select{ |task| task.app_list_position == indexPath.row }.first

    cell.title_label.text = current_task.title

    if indexPath.row == 0
      cell.container_view.frame = [[10, 4],[self.view.frame.size.width - 20, self.view.frame.size.height / 10]]
    elsif indexPath.row == tasks_for_section.count - 1
      cell.container_view.frame = [[10, 2],[self.view.frame.size.width - 20, self.view.frame.size.height / 10]]
    else
      cell.container_view.frame = [[10, 2],[self.view.frame.size.width - 20, self.view.frame.size.height / 10]]
    end

    if tasks_for_section.select{ |task| task.app_list_position == indexPath.row }.first.complete == 1
      # cell.image_view.image = UIImage.imageNamed("blue_circle_tick.png")
      cell.image_view.setBackgroundImage(UIImage.imageNamed("blue_circle_tick.png"), forState: UIControlStateNormal)
      cell.image_view.removeTarget(self, action: "complete_task:", forControlEvents: UIControlEventTouchUpInside)
      cell.image_view.addTarget(self, action: "uncomplete_task:", forControlEvents: UIControlEventTouchUpInside)
    else
      # cell.image_view.image = UIImage.imageNamed("blue_circle_empty.png")
      cell.image_view.setBackgroundImage(UIImage.imageNamed("blue_circle_empty.png"), forState: UIControlStateNormal)
      cell.image_view.removeTarget(self, action: "uncomplete_task:", forControlEvents: UIControlEventTouchUpInside)
      cell.image_view.addTarget(self, action: "complete_task:", forControlEvents: UIControlEventTouchUpInside)
    end
    cell.image_view.tag = indexPath.row

    due_date = tasks_for_section.select{ |task| task.app_list_position == indexPath.row }.first.due_date
    if due_date.nil?
      cell.date_label.text = "Due: Ongoing"
    else
      cell.date_label.text = "Due: #{due_date.day}-#{due_date.month}-#{due_date.year}"
    end

    cell.backgroundColor = UIColor.clearColor

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

  def tableView(tableView, editingStyleForRowAtIndexPath: indexPath)
    if table_view.isEditing == true
      UITableViewCellEditingStyleNone
    else
      UITableViewCellEditingStyleDelete
    end
  end

  def tableView(tableView, shouldIndentWhileEditingRowAtIndexPath: indexPath)
    false
  end

  def tableView(tableView, moveRowAtIndexPath: sourceIndexPath, toIndexPath: destinationIndexPath)
    if sourceIndexPath.section == destinationIndexPath.section
      if sourceIndexPath.section == 0
        saved_tasks = Task.where(type: type, complete: 0)
      elsif sourceIndexPath.section == 1
        saved_tasks = Task.where(type: type, complete: 1)
      end

      # @tasks.insert(destinationIndexPath.row, @tasks.delete_at(sourceIndexPath.row))
      # table_view.reloadData

      if sourceIndexPath.row < destinationIndexPath.row
        (sourceIndexPath.row..destinationIndexPath.row).each do |row|
          if row == sourceIndexPath.row
            saved_tasks.where(app_list_position: sourceIndexPath.row).first.app_list_position = nil
          else
            saved_tasks.where(app_list_position: row).first.app_list_position = row - 1
          end
        end
        source_saved_task = saved_tasks.where(app_list_position: nil).first
        source_saved_task.app_list_position = destinationIndexPath.row if source_saved_task
      else
        (destinationIndexPath.row..sourceIndexPath.row).to_a.reverse.each do |row|
          if row == sourceIndexPath.row
            saved_tasks.where(app_list_position: sourceIndexPath.row).first.app_list_position = nil
          else
            saved_tasks.where(app_list_position: row).first.app_list_position = row + 1
          end
        end
        source_saved_task = saved_tasks.where(app_list_position: nil).first
        source_saved_task.app_list_position = destinationIndexPath.row if source_saved_task
      end
      Task.save
    end
    table_view.reloadData
  end

  def tableView(tableView, canMoveRowAtIndexPath: indexPath)
    true
  end

  def tableView(tableView, targetIndexPathForMoveFromRowAtIndexPath: sourceIndexPath, toProposedIndexPath: proposedDestinationIndexPath)
    if sourceIndexPath.section != proposedDestinationIndexPath.section
      row = 0
      if sourceIndexPath.section < proposedDestinationIndexPath.section
        row = table_view.numberOfRowsInSection(sourceIndexPath.section) - 1
      end
      return NSIndexPath.indexPathForRow(row, inSection: sourceIndexPath.section)
    else
      return proposedDestinationIndexPath
    end
  end

  editingStyle = UITableViewCellEditingStyleDelete
  def tableView(tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)
    # @list.delete_at(indexPath.row)
    # Task.save_tasks(@type, @list)
    # tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimationFade)
  end

  def tableView(tableView, editActionsForRowAtIndexPath: indexPath)
    delete_button = UITableViewRowAction.rowActionWithStyle(UITableViewRowActionStyleDefault, title: 'Delete', handler: proc { |action, indexPath| delete_task(indexPath.section, indexPath.row) })
    delete_button.backgroundColor = UIColor.colorWithRed(250.0/255.0, green:170.0/255.0, blue:220.0/255.0, alpha:1.0)
    [delete_button]
  end
end
