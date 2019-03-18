import UIKit

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
        loginWireframe.presentHomeScreen()
    }
}
