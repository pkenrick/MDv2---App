class AppDelegate
  include CDQ

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    cdq.setup

    sessionsController = SessionsController.alloc.init
    sessionsController.title = 'Monkey Do'
    sessionsController.view.backgroundColor = UIColor.colorWithRed(110.0/255.0, green:200.0/255.0, blue:255.0/255.0, alpha:1.0)

    # navigationController = UINavigationController.alloc.initWithRootViewController(sessionsController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = sessionsController
    @window.makeKeyAndVisible

    UINavigationBar.appearance.barTintColor = UIColor.colorWithRed(110.0/255.0, green:200.0/255.0, blue:255.0/255.0, alpha:1.0)


    true
  end

end
