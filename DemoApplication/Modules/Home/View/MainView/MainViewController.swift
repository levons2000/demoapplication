import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var menuButton: UIBarButtonItem!  
    @IBOutlet weak var mainTableView: UITableView!
    
    var window: UIWindow?
    
    let mainInteractor: MainInteractor = MainInteractor.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let rowPageScreenViewController = UIStoryboard.init(name: "RowPage",
                                                            bundle: nil).instantiateViewController(withIdentifier:
                                                                "CollapsingTableViewController") as! CollapsingTableViewController
        rowPageScreenViewController.indexOfNew = indexPath.row
        self.window!.rootViewController = rowPageScreenViewController
        self.window!.makeKeyAndVisible()
    }
    
    
}
