import UIKit

class LoginWireframe: NSObject, LoginWireframeProtocol {
    private static var instance: LoginWireframe = {
        return LoginWireframe()
    }()
    
    class var sharedInstance: LoginWireframe {
        return instance
    }
    
    private override init() {
        
    }
    
    var loginScreenViewController: LoginViewController?
    var window: UIWindow?
    
    func presentHomeScreen() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = UIStoryboard.init(name: "Home",
                                                    bundle: nil).instantiateViewController(withIdentifier:
                                                        "HomeViewController") as? SWRevealViewController
        self.window!.rootViewController = homeViewController
        self.window!.makeKeyAndVisible()
    }
    
    func presentRegisterScreen() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = UIStoryboard.init(name: "Register",
                                                   bundle: nil).instantiateViewController(withIdentifier:
                                                    "RegisterViewController") as? RegisterViewController
        self.window!.rootViewController = homeViewController
        self.window!.makeKeyAndVisible()
    }
}
