import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var menuButton: UIBarButtonItem!  
    @IBOutlet weak var mainTableView: UITableView!
    
    var window: UIWindow?
    
    let mainInteractor: MainInteractor = MainInteractor.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 0.1294, green: 0.5882, blue: 0.9529, alpha: 1)
        if revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController().revealToggle(_:))
            self.view.addGestureRecognizer((revealViewController().panGestureRecognizer()))
        }
        mainInteractor.initTableViewItem(url: URL(string: APIURL)!, tableView: mainTableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainInteractor.imageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        cell.newsContent.text = mainInteractor.dataArray[indexPath.row].title!
        if  mainInteractor.imageArray[indexPath.row] != nil {
            cell.newsImage.image = mainInteractor.imageArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rowPageNavigationController = UIStoryboard.init(name: "RowPage",
                                                            bundle: nil).instantiateViewController(withIdentifier:
                                                                "CollapsingNavigationController") as! UINavigationController
        mainInteractor.indexOfNew = indexPath.row
        self.window!.rootViewController = rowPageNavigationController
        self.window!.makeKeyAndVisible()
    }
    
    
}
