import UIKit
import FirebaseAuth

class SplashViewController: UIViewController, SplashViewControllerProtocol {

    var window: UIWindow?
    let splashWireframe = SplashWireframe.sharedInstance
    let splashInteractor = SplashInteractor.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        window = UIWindow(frame: UIScreen.main.bounds);
        splashWireframe.window = window
        splashInteractor.loading()
    }
}
