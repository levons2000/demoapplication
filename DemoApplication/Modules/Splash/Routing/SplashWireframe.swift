import UIKit

class SplashWireframe: NSObject, SplashWireframeProtocol {
    
    private static var instance: SplashWireframe = {
        return SplashWireframe()
    }()
    
    class var sharedInstance: SplashWireframe {
        return instance
    }
    
    var splashScreenViewController: SplashViewController?
    var window: UIWindow?
    
    func presentSplashViewControllerInWindow() {
        let splashScreenViewController = UIStoryboard.init(name: "Splash",
                                                     bundle: nil).instantiateViewController(withIdentifier:
                                                        "SplashViewController") as? SplashViewController
        self.splashScreenViewController = splashScreenViewController
        self.window!.rootViewController = splashScreenViewController
        self.window!.makeKeyAndVisible()
    }
    
    func presentLoginViewController() {
        let loginViewController = UIStoryboard.init(name: "Login",
                                                           bundle: nil).instantiateViewController(withIdentifier:
                                                            "LoginViewController") as? LoginViewController
        self.window!.rootViewController = loginViewController
        self.window!.makeKeyAndVisible()
    }
    
    func presentHomeViewController() {
        
    }
    
    
}
