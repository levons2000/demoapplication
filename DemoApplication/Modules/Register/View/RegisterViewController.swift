import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController, RegisterViewControllerProtocol {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var create: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewStyle()
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
        let registerInteractor = RegisterInteractor.sharedInstance
        registerInteractor.signIn(controller: self, username: username, email: email, password: password)
        create.isEnabled = true
    }
    
    func updateViewStyle() {
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
        password.clearsOnInsertion = false
        password.isSecureTextEntry = true
        create.layer.borderColor = borderColor.cgColor
        create.layer.cornerRadius = 19.0
    }
}
