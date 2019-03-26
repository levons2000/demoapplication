import UIKit
import FirebaseAuth

class SplashViewController: UIViewController {

    var window: UIWindow?
    var splashWireframe = SplashWireframe.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        window = UIWindow(frame: UIScreen.main.bounds);
        splashWireframe.window = window
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
