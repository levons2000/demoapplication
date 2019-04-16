import Foundation

@objc protocol RegisterInteractorProtocol {
    func signIn(controller: UIViewController, username: String,email: String, password: String)
}
