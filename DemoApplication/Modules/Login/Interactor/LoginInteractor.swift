import UIKit
import FirebaseAuth

class LoginInteractor: NSObject, LoginInteractorProtocol {
    let loginWireframe: LoginWireframe = LoginWireframe.sharedInstance
    
    private static var instance: LoginInteractor = {
        return LoginInteractor()
    }()
    
    class var sharedInstance: LoginInteractor {
        return instance
    }
    
    private override init() {
        
    }
    
    func signIn(email: String, password: String, controller: UIViewController) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil && user != nil {
                UserDefaults().set(email, forKey: EmailKey)
                UserDefaults().set(password, forKey: PasswordKey)
                self.loginWireframe.presentHomeScreen()
            } else {
                Utils.showToast(controller: controller, message: "Bad Email or Password", seconds: 3)
            }
        }
    }
}
