import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, LoginViewControllerProtocol {

    @IBOutlet weak var loginTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let loginWireframe: LoginWireframe = LoginWireframe.sharedInstance
    let loginInteractor: LoginInteractor = LoginInteractor.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViewsStyle()
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        guard let email = loginTextView.text else {return}
        guard let password = passwordTextView.text else {return}
        loginButton.isEnabled = false
        loginInteractor.signIn(email: email, password: password, controller: self)
        loginButton.isEnabled = true
    }
    
    @IBAction func registerAction(_ sender: Any) {
        loginWireframe.presentRegisterScreen()
    }
    
    
    
    func updateViewsStyle() {
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 0.1294, green: 0.5882, blue: 0.9529, alpha: 1)
        
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
}
