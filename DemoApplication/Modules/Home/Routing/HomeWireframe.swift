import UIKit

class HomeWireframe: NSObject, HomeWireframeProtocol {
    
    var window: UIWindow? = nil
    
    private static var instance: HomeWireframe = {
        return HomeWireframe()
    }()
    
    class var sharedInstance: HomeWireframe {
        return instance
    }
    
    private override init() {
        
    }
    
    func presentCollapsingPage() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rowPageNavigationController = UIStoryboard.init(name: "RowPage",
                                                            bundle: nil).instantiateViewController(withIdentifier:
                                                                "CollapsingNavigationContr") as! UINavigationController
        window!.rootViewController = rowPageNavigationController
        window!.makeKeyAndVisible()
    }
}
