import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var username: UITextView!
    @IBOutlet weak var email: UITextView!
    @IBOutlet weak var password: UITextView!
    @IBOutlet weak var create: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let borderColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        username.layer.borderWidth = 0.5
        username.layer.borderColor = borderColor.cgColor
        username.layer.cornerRadius = 19.0
        email.layer.borderWidth = 0.5
        email.layer.borderColor = borderColor.cgColor
        email.layer.cornerRadius = 19.0
        password.layer.borderWidth = 0.5
        password.layer.borderColor = borderColor.cgColor
        password.layer.cornerRadius = 19.0
        create.layer.borderColor = borderColor.cgColor
        create.layer.cornerRadius = 19.0
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        handleSignup()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let splashWireframe: SplashWireframe = SplashWireframe.sharedInstance
        splashWireframe.presentLoginViewController()
    }
    
    func handleSignup() {
        guard let username = username.text else {return}
        guard let email = email.text else {return}
        guard let password = password.text else {return}
        create.isEnabled = false
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
                self.showToast(controller: self, message: "Bad Data", seconds: 2)
            }
        }
        create.isEnabled = true
    }
    
    func showToast(controller: UIViewController, message: String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
