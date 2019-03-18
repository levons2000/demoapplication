import UIKit

class SplashViewController: UIViewController {

    var window: UIWindow?
    var splashWireframe = SplashWireframe.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        window = UIWindow(frame: UIScreen.main.bounds);
        splashWireframe.window = window
        sleep(3)
        splashWireframe.presentLoginViewController()
    }
}
