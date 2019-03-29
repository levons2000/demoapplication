import UIKit

class RowPageWireframe: NSObject, RowPageWireframeProtocol {

    var newsIndex = 0
    
    var window: UIWindow?
    
    let mainInteractor: MainInteractor = MainInteractor.sharedInstance
    
    private static var instance: RowPageWireframe = {
        return RowPageWireframe()
    }()
    
    class var sharedInstance: RowPageWireframe {
        return instance
    }
    
    private override init() {
        
    }
    
    func presentWebPage() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let webViewController = UIStoryboard.init(name: "WebPage",
                                                    bundle: nil).instantiateViewController(withIdentifier:
                                                        "WebPageNavigationController") as? UINavigationController
        self.window?.rootViewController = webViewController
        self.window?.makeKeyAndVisible()
    }
}
