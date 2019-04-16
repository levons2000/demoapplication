import UIKit
import FirebaseAuth

class RegisterInteractor: NSObject, RegisterInteractorProtocol {
    
    private static var instance: RegisterInteractor = {
        return RegisterInteractor()
    }()
    
    class var sharedInstance: RegisterInteractor {
        return instance
    }
    
    private override init() {
        
    }
    
    func signIn(controller: UIViewController, username: String,email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (auth, error) in
            if error == nil && auth != nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges(completion: { (error) in
                    if error == nil {
                        UserDefaults().set(email, forKey: EmailKey)
                        UserDefaults().set(password, forKey: PasswordKey)
                        let loginwireframe: LoginWireframe = LoginWireframe.sharedInstance
                        loginwireframe.presentHomeScreen()
                    }
                })
            } else {
                Utils.showToast(controller: controller, message: "Bad Data", seconds: 2)
            }
        }
    }
}
