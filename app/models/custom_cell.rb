class CustomCell < UITableViewCell

  attr_accessor :container_view, :image_view, :title_label, :date_label

  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super
    self.contentView.backgroundColor = UIColor.lightGrayColor
    self.contentView.backgroundColor = UIColor.colorWithRed(215.0/255.0, green:240.0/255.0, blue:250.0/255.0, alpha:1.0)

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
    self.container_view.addSubview(@date_label)

    self
  end

  def viewDidLoad
    super
    self
  end

  def layoutSubviews
    super

    image_view.frame = [[container_view.frame.size.width / 20, container_view.frame.size.width / 20],[container_view.frame.size.width / 8, container_view.frame.size.width / 8]]
    title_label.frame = [[container_view.frame.size.width / 20 + image_view.frame.size.width + container_view.frame.size.width / 20, container_view.frame.size.width / 30],[container_view.frame.size.width / 8 * 7 - (container_view.frame.size.width / 20 * 3), container_view.frame.size.width / 12]]
    date_label.frame = [[container_view.frame.size.width / 20 + image_view.frame.size.width + container_view.frame.size.width / 20, container_view.frame.size.width / 30 + title_label.frame.size.height], [container_view.frame.size.width / 8 * 7 - (container_view.frame.size.width / 20 * 3), container_view.frame.size.width / 16]]

    # image_label.backgroundColor = UIColor.colorWithRed(110.0/255.0, green:200.0/255.0, blue:255.0/255.0, alpha:1.0)
    # image_view.image = UIImage.imageNamed("blue_circle_tick.png")

    # self.textLabel.removeFromSuperview
    # self.textLabel.frame = [[container_view.frame.size.width / 20 + image_view.frame.size.width + container_view.frame.size.width / 20, container_view.frame.size.width / 30],[container_view.frame.size.width / 8 * 7 - (container_view.frame.size.width / 20 * 3), container_view.frame.size.width / 12]]
    # self.textLabel.color = UIColor.colorWithRed(90.0/255.0, green:180.0/255.0, blue:235.0/255.0, alpha:1.0)
    # self.textLabel.font = UIFont.fontWithName('AmericanTypewriter', size: 22)
    # container_view.addSubview(self.textLabel)



  end



end
