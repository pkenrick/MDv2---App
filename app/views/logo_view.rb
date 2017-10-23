class LogoView < UIView

  attr_accessor :monkey_boy, :monkey_girl, :title, :tag

  def self.build_logo(bounds)
    logo_view = LogoView.alloc.initWithFrame(bounds)
    # logo_view.backgroundColor = UIColor.blueColor
    logo_view.add_monkeys
    logo_view.add_title
    logo_view.add_tag
    logo_view
  end

  def add_monkeys
    @monkey_boy = UIImageView.alloc.initWithImage(UIImage.imageNamed("MonkeyBoy.png"))
    @monkey_girl = UIImageView.alloc.initWithImage(UIImage.imageNamed("MonkeyGirl.png"))

    self.addSubview(monkey_boy)
    self.addSubview(monkey_girl)

    monkey_boy.translatesAutoresizingMaskIntoConstraints = false
    monkey_girl.translatesAutoresizingMaskIntoConstraints = false

    monkey_boy_bottom = NSLayoutConstraint.constraintWithItem(monkey_boy, attribute: NSLayoutAttributeBottom, relatedBy: NSLayoutRelationEqual, toItem: self, attribute: NSLayoutAttributeCenterY, multiplier: 1.0, constant: 0)
    monkey_boy_right = NSLayoutConstraint.constraintWithItem(monkey_boy, attribute: NSLayoutAttributeRight, relatedBy: NSLayoutRelationEqual, toItem: self, attribute: NSLayoutAttributeCenterX, multiplier: 1.0, constant: 0)
    monkey_boy_height = NSLayoutConstraint.constraintWithItem(monkey_boy, attribute: NSLayoutAttributeHeight, relatedBy: NSLayoutRelationEqual, toItem: nil, attribute: 0, multiplier: 1.0, constant: self.size.height / 2)
    monkey_boy_width = NSLayoutConstraint.constraintWithItem(monkey_boy, attribute: NSLayoutAttributeWidth, relatedBy: NSLayoutRelationEqual, toItem: nil, attribute: 0, multiplier: 1.0, constant: self.size.height / 2)

    monkey_girl_bottom = NSLayoutConstraint.constraintWithItem(monkey_girl, attribute: NSLayoutAttributeBottom, relatedBy: NSLayoutRelationEqual, toItem: self, attribute: NSLayoutAttributeCenterY, multiplier: 1.0, constant: 0)
    monkey_girl_left = NSLayoutConstraint.constraintWithItem(monkey_girl, attribute: NSLayoutAttributeLeft, relatedBy: NSLayoutRelationEqual, toItem: self, attribute: NSLayoutAttributeCenterX, multiplier: 1.0, constant: 0)
    monkey_girl_height = NSLayoutConstraint.constraintWithItem(monkey_girl, attribute: NSLayoutAttributeHeight, relatedBy: NSLayoutRelationEqual, toItem: nil, attribute: 0, multiplier: 1.0, constant: self.size.height / 2)
    monkey_girl_width = NSLayoutConstraint.constraintWithItem(monkey_girl, attribute: NSLayoutAttributeWidth, relatedBy: NSLayoutRelationEqual, toItem: nil, attribute: 0, multiplier: 1.0, constant: self.size.height / 2)

    self.addConstraint(monkey_boy_bottom)
    self.addConstraint(monkey_boy_right)
    self.addConstraint(monkey_boy_height)
    self.addConstraint(monkey_boy_width)

    self.addConstraint(monkey_girl_bottom)
    self.addConstraint(monkey_girl_left)
    self.addConstraint(monkey_girl_height)
    self.addConstraint(monkey_girl_width)
  end

  def add_title
    @title = UILabel.alloc.initWithFrame(CGRectZero)
    title.text = 'Monkey-Do!'
    title.font = UIFont.fontWithName("Chalkduster", size: 50)
    title.numberOfLines = 1
    title.adjustsFontSizeToFitWidth = true
    # title.backgroundColor = UIColor.greenColor
    self.addSubview(title)

    title.translatesAutoresizingMaskIntoConstraints = false
    title_top = NSLayoutConstraint.constraintWithItem(title, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: self, attribute: NSLayoutAttributeTop, multiplier: 1.0, constant: self.size.height / 10 * 5)
    title_left = NSLayoutConstraint.constraintWithItem(title, attribute: NSLayoutAttributeLeft, relatedBy: NSLayoutRelationEqual, toItem: self, attribute: NSLayoutAttributeLeft, multiplier: 1.0, constant: self.size.width / 8)
    title_right = NSLayoutConstraint.constraintWithItem(title, attribute: NSLayoutAttributeRight, relatedBy: NSLayoutRelationEqual, toItem: self, attribute: NSLayoutAttributeRight, multiplier: 1.0, constant: - self.size.width / 8)
    title_height = NSLayoutConstraint.constraintWithItem(title, attribute: NSLayoutAttributeHeight, relatedBy: NSLayoutRelationEqual, toItem: monkey_boy, attribute: NSLayoutAttributeHeight, multiplier: 0.5, constant: 0)

    self.addConstraint(title_top)
    self.addConstraint(title_left)
    self.addConstraint(title_right)
    self.addConstraint(title_height)
  end

  def add_tag
    @tag = UILabel.alloc.initWithFrame(CGRectZero)
    tag.text = "The to-do list app for couples"
    tag.font = UIFont.fontWithName("AmericanTypewriter", size: 20)
    tag.numberOfLines = 1
    tag.adjustsFontSizeToFitWidth = true
    # tag.backgroundColor = UIColor.redColor
    self.addSubview(tag)

    tag.translatesAutoresizingMaskIntoConstraints = false
    tag_top = NSLayoutConstraint.constraintWithItem(tag, attribute: NSLayoutAttributeTop, relatedBy: NSLayoutRelationEqual, toItem: self, attribute: NSLayoutAttributeTop, multiplier: 1.0, constant: self.size.height / 10 * 8)
    tag_left = NSLayoutConstraint.constraintWithItem(tag, attribute: NSLayoutAttributeLeft, relatedBy: NSLayoutRelationEqual, toItem: title, attribute: NSLayoutAttributeLeft, multiplier: 1.0, constant: 0)
    tag_right = NSLayoutConstraint.constraintWithItem(tag, attribute: NSLayoutAttributeRight, relatedBy: NSLayoutRelationEqual, toItem: title, attribute: NSLayoutAttributeRight, multiplier: 1.0, constant: 0)

    self.addConstraint(tag_top)
    self.addConstraint(tag_left)
    self.addConstraint(tag_right)
  end

end
