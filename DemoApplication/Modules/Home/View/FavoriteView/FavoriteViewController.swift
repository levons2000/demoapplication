import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavoriteViewControllerProtocol {
    
    let mainInteractor: MainInteractor = MainInteractor.sharedInstance
    let favoriteInteractor: FavoriteInteractor = FavoriteInteractor.sharedInstance
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var progressBar = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initActivityIndicator()
        self.favoriteTableView.delegate = self
        self.favoriteTableView.dataSource = self
        if revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController().revealToggle(_:))
            self.view.addGestureRecognizer((revealViewController().panGestureRecognizer()))
        }
        favoriteInteractor.initFavoriteTableView(progressBar: progressBar, tableView: favoriteTableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteInteractor.favoriteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavoriteTableViewCell = favoriteTableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell") as! FavoriteTableViewCell
        cell.newsContent.text = favoriteInteractor.favoriteArray[indexPath.row].title
        if favoriteInteractor.favoriteArray[indexPath.row].image != nil {
            cell.newsImage.image = UIImage(data: favoriteInteractor.favoriteArray[indexPath.row].image! as Data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let homeWireframe: HomeWireframe = HomeWireframe.sharedInstance
        mainInteractor.indexOfNew = indexPath.row
        CategoriesInteractor.sharedInstance.isFavorite = true
        homeWireframe.presentCollapsingPage()
    }

    func initActivityIndicator() {
        progressBar = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        progressBar.style = UIActivityIndicatorView.Style.gray
        progressBar.center = self.view.center
        self.view.addSubview(progressBar)
    }
}
