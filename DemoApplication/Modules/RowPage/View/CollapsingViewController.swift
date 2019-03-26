import UIKit

class CollapsingViewController: UIViewController {
    
    var indexOfNew: Int = 0
    let mainInteractor: MainInteractor = MainInteractor.sharedInstance
    
    @IBOutlet weak var headerView: MGCollapsingHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.minimumHeaderHeight = 230
        headerView.setCollapsingConstraints()
        
    }
}
