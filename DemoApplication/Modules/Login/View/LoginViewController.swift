import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextView: UITextView!
    @IBOutlet weak var passwordTextView: UITextView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var loginWireframe: LoginWireframe = LoginWireframe.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let borderColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        loginTextView.layer.borderWidth = 0.5
        loginTextView.layer.borderColor = borderColor.cgColor
        loginTextView.layer.cornerRadius = 19.0
        passwordTextView.layer.borderWidth = 0.5
        passwordTextView.layer.borderColor = borderColor.cgColor
        passwordTextView.layer.cornerRadius = 19.0
        loginButton.layer.borderColor = borderColor.cgColor
        loginButton.layer.cornerRadius = 19.0
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        guard let email = loginTextView.text else {return}
        guard let password = passwordTextView.text else {return}
        loginButton.isEnabled = false
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil && user != nil {
                UserDefaults().set(email, forKey: EmailKey)
                UserDefaults().set(password, forKey: PasswordKey)
                self.loginWireframe.presentHomeScreen()
            } else {
                self.showToast(controller: self, message: "Bad Email or Password", seconds: 3)
            }
        }
    }
    
    @IBAction func registerAction(_ sender: Any) {
        loginWireframe.presentRegisterScreen()
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
