import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MainViewControllerProtocol {
    

    @IBOutlet weak var menuButton: UIBarButtonItem!  
    @IBOutlet weak var mainTableView: UITableView!
    
    var progressBar = UIActivityIndicatorView()
    
    var window: UIWindow?
    
    let mainInteractor: MainInteractor = MainInteractor.sharedInstance
    let categoriesInteractor: CategoriesInteractor = CategoriesInteractor.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 0.1294, green: 0.5882, blue: 0.9529, alpha: 1)
        categoriesInteractor.typeOfNew = nil
        initActivityIndecator()
        if revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController().revealToggle(_:))
            self.view.addGestureRecognizer((revealViewController().panGestureRecognizer()))
        }
        mainInteractor.initMainTableView(tableView: mainTableView, progressBar: progressBar)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainInteractor.mainDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        cell.newsContent.text = mainInteractor.mainDataArray[indexPath.row].title!
        if  mainInteractor.mainImageArray[indexPath.row] != nil {
            cell.newsImage.image = mainInteractor.mainImageArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let homeWireframe: HomeWireframe = HomeWireframe.sharedInstance
        categoriesInteractor.indexOfNew = indexPath.row
        categoriesInteractor.typeOfNew = nil
        homeWireframe.presentCollapsingPage()
    }
    
    func initActivityIndecator() {
        progressBar = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        progressBar.style = UIActivityIndicatorView.Style.gray
        progressBar.center = self.view.center
        self.view.addSubview(progressBar)
    }
}
