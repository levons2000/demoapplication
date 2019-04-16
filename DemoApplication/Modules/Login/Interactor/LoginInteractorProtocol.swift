import Foundation

@objc protocol LoginInteractorProtocol {
    func signIn(email: String, password: String, controller: UIViewController)
}
