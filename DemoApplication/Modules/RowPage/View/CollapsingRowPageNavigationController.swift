import UIKit
import Floaty

class CollapsingRowPageNavigationController: UINavigationController {
    override func viewDidLoad() {
        let floaty = Floaty()
        floaty.buttonColor = UIColor(red: 0.1294, green: 0.5882, blue: 0.9529, alpha: 1.0)
        floaty.itemButtonColor = UIColor.white
        floaty.plusColor = UIColor.white
        floaty.addItem(icon: UIImage(named: "favorite")) { item in
            let collapsingInteractor: RowPageInteractor = RowPageInteractor.sharedInstance
            collapsingInteractor.addToFavorite()
        }
        floaty.addItem(icon: UIImage(named: "open_in_browser")) { item in
            let wireframe: RowPageWireframe = RowPageWireframe.sharedInstance
            wireframe.presentWebPage()
        }
        floaty.addItem(icon: UIImage(named: "save")) { item in
            
        }
        self.view.addSubview(floaty)
    }
}
