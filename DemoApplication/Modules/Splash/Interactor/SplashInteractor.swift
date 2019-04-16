import UIKit
import FirebaseAuth

class SplashInteractor: NSObject, SplashInteractorProtocol {
    
    let splashWireframe: SplashWireframe = SplashWireframe.sharedInstance
    
    private static var instance: SplashInteractor = {
        return SplashInteractor()
    }()
    
    class var sharedInstance: SplashInteractor {
        return instance
    }
    
    private override init() {
        
    }
    
    func loading() {
        if UserDefaults().string(forKey: EmailKey) != nil && UserDefaults().string(forKey: PasswordKey) != nil {
            Auth.auth().signIn(withEmail: UserDefaults().string(forKey: EmailKey)!,
                               password: UserDefaults().string(forKey: PasswordKey)!) { (auth, error) in
                                if error == nil && auth != nil {
                                    sleep(2)
                                    self.splashWireframe.presentHomeViewController()
                                } else {
                                    sleep(2)
                                    self.splashWireframe.presentLoginViewController()
                                }
            }
        } else {
            sleep(2)
            splashWireframe.presentLoginViewController()
        }
    }
}
