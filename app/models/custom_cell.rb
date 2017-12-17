class CustomCell < UITableViewCell

  attr_accessor :container_view, :image_view, :title_label, :date_label

  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super
    # self.contentView.backgroundColor = UIColor.colorWithRed(215.0/255.0, green:240.0/255.0, blue:250.0/255.0, alpha:1.0)
    self.contentView.backgroundColor = UIColor.clearColor

    @container_view = UIView.alloc.init
    container_view.backgroundColor = UIColor.whiteColor
    container_view.layer.borderWidth = 1
    container_view.layer.borderColor = UIColor.colorWithRed(200.0/255.0, green:200.0/255.0, blue:200.0/255.0, alpha:1.0).CGColor
    self.contentView.addSubview(container_view)

    @image_view = UIImageView.alloc.init
    self.container_view.addSubview(@image_view)

    @title_label = UILabel.alloc.init
    @title_label.color = UIColor.colorWithRed(90.0/255.0, green:180.0/255.0, blue:235.0/255.0, alpha:1.0)
    @title_label.font = UIFont.fontWithName('AmericanTypewriter', size: 22)
    container_view.addSubview(@title_label)

    @date_label = UILabel.alloc.init
    @date_label.color = UIColor.lightGrayColor
    @date_label.font = UIFont.fontWithName('Helvetica', size: 14)
    @date_label.sizeToFit
    self.container_view.addSubview(@date_label)

    self
  end

  def viewDidLoad
    super
    self
  end

  def layoutSubviews
    super

    image_view.frame = [[container_view.frame.size.width / 30, container_view.frame.size.height / 2 - container_view.frame.size.height / 2 / 2],[container_view.frame.size.height / 2, container_view.frame.size.height / 2]]

    # title_label.backgroundColor = UIColor.redColor
    title_label.translatesAutoresizingMaskIntoConstraints = false
    title_label_left = NSLayoutConstraint.constraintWithItem(title_label, attribute: NSLayoutAttributeLeft, relatedBy: NSLayoutRelationEqual, toItem: image_view, attribute: NSLayoutAttributeRight, multiplier: 1.0, constant: container_view.frame.size.width / 30)
    title_label_right = NSLayoutConstraint.constraintWithItem(title_label, attribute: NSLayoutAttributeRight, relatedBy: NSLayoutRelationEqual, toItem: container_view, attribute: NSLayoutAttributeRight, multiplier: 1.0, constant: -container_view.frame.size.width / 30)
    title_label_top = NSLayoutConstraint.constraintWithItem(title_label, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: container_view, attribute: NSLayoutAttributeTop, multiplier: 1.0, constant: container_view.frame.size.width / 30)
    title_label_height = NSLayoutConstraint.constraintWithItem(title_label, attribute: NSLayoutAttributeHeight, relatedBy: NSLayoutRelationEqual, toItem: container_view, attribute: NSLayoutAttributeHeight, multiplier: 0.4, constant: 0.0)
    container_view.addConstraint(title_label_left)
    container_view.addConstraint(title_label_right)
    container_view.addConstraint(title_label_top)
    container_view.addConstraint(title_label_height)


    # date_label.backgroundColor = UIColor.yellowColor
    date_label.translatesAutoresizingMaskIntoConstraints = false
    date_label_left = NSLayoutConstraint.constraintWithItem(date_label, attribute: NSLayoutAttributeLeft, relatedBy: NSLayoutRelationEqual, toItem: title_label, attribute: NSLayoutAttributeLeft, multiplier: 1.0, constant: 0.0)
    date_label_top = NSLayoutConstraint.constraintWithItem(date_label, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: title_label, attribute: NSLayoutAttributeBottom, multiplier: 1.0, constant: 0)
    container_view.addConstraint(date_label_left)
    container_view.addConstraint(date_label_top)
  end



end
