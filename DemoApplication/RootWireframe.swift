import UIKit

class RootWireframe: NSObject {
    
    let splashScreenWireframe: SplashWireframe?
    
    override init() {
        self.splashScreenWireframe = SplashWireframe.sharedInstance
    }
    
    func application(didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?, window: UIWindow?) -> Bool {
        self.splashScreenWireframe?.window = window
        self.splashScreenWireframe?.presentSplashViewControllerInWindow()
        return true
    }
}
