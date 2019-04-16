import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CategoriesViewControllerProtocol {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var categoriesTableView: UITableView!
    
    var progressBar = UIActivityIndicatorView()
    
    var typeOfNew: NewsType = .Sport
    
    var window: UIWindow?
    
    let categoriesInteractor: CategoriesInteractor = CategoriesInteractor.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initActivityIndicator()
        if revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController().revealToggle(_:))
            self.view.addGestureRecognizer((revealViewController().panGestureRecognizer()))
        }
        setupView()
    }
    
    private func setupView() {
        setupSegmentedControl()
        updateView()
    }
    
    private func updateView() {
        switch segmentController.selectedSegmentIndex {
        case 0:
            categoriesInteractor.typeOfNew = NewsType.Sport
            categoriesInteractor.initCategoriesTableView(tableView: categoriesTableView, progressBar: progressBar)
        case 1:
            categoriesInteractor.typeOfNew = NewsType.Food
            categoriesInteractor.initCategoriesTableView(tableView: categoriesTableView, progressBar: progressBar)
        case 2:
            categoriesInteractor.typeOfNew = NewsType.Politics
            categoriesInteractor.initCategoriesTableView(tableView: categoriesTableView, progressBar: progressBar)
        case 3:
            categoriesInteractor.typeOfNew = NewsType.Tech
            categoriesInteractor.initCategoriesTableView(tableView: categoriesTableView, progressBar: progressBar)
        default: break
        }
    }
    
    private func setupSegmentedControl() {
        segmentController.removeAllSegments()
        segmentController.insertSegment(withTitle: "Sport", at: 0, animated: false)
        segmentController.insertSegment(withTitle: "Food", at: 1, animated: false)
        segmentController.insertSegment(withTitle: "Politics", at: 2, animated: false)
        segmentController.insertSegment(withTitle: "Tech", at: 3, animated: false)
        segmentController.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        segmentController.selectedSegmentIndex = 0
    }
    
    @objc func selectionDidChange(sender: UISegmentedControl) {
        updateView()
    }
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParent: self)
    }
    
    func reloadTableViewData(tableView: UITableView) {
        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !categoriesInteractor.isClear {
            switch categoriesInteractor.typeOfNew {
            case .some(.Sport):
                self.typeOfNew = NewsType.Sport
                return categoriesInteractor.sportImageArray.count
            case .some(.Food):
                self.typeOfNew = NewsType.Food
                return categoriesInteractor.foodImageArray.count
            case .some(.Politics):
                self.typeOfNew = NewsType.Politics
                return categoriesInteractor.politicsImageArray.count
            case .some(.Tech):
                self.typeOfNew = NewsType.Tech
                return categoriesInteractor.techImageArray.count
            case .none:
                break
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoriesTableViewCell = categoriesTableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell") as! CategoriesTableViewCell
        switch categoriesInteractor.typeOfNew {
        case .some(.Sport):
            cell.newsContent.text = categoriesInteractor.sportDataArray[indexPath.row].title!
            if categoriesInteractor.sportImageArray[indexPath.row] != nil {
                cell.newsImage.image = categoriesInteractor.sportImageArray[indexPath.row]
            }
        case .some(.Food):
            cell.newsContent.text = categoriesInteractor.foodDataArray[indexPath.row].title!
            if categoriesInteractor.foodImageArray[indexPath.row] != nil {
                cell.newsImage.image = categoriesInteractor.foodImageArray[indexPath.row]
            }
        case .some(.Politics):
            cell.newsContent.text = categoriesInteractor.politicsDataArray[indexPath.row].title!
            if categoriesInteractor.politicsImageArray[indexPath.row] != nil {
                cell.newsImage.image = categoriesInteractor.politicsImageArray[indexPath.row]
            }
        case .some(.Tech):
            cell.newsContent.text = categoriesInteractor.techDataArray[indexPath.row].title!
            if categoriesInteractor.techImageArray[indexPath.row] != nil {
                cell.newsImage.image = categoriesInteractor.techImageArray[indexPath.row]
            }
        case .none:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let homeWireframe: HomeWireframe = HomeWireframe.sharedInstance
        categoriesInteractor.indexOfNew = indexPath.row
        categoriesInteractor.typeOfNew = self.typeOfNew
        categoriesInteractor.isFavorite = false
        homeWireframe.presentCollapsingPage()
    }
    
    func initActivityIndicator() {
        progressBar = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        progressBar.style = UIActivityIndicatorView.Style.gray
        progressBar.center = self.view.center
        self.view.addSubview(progressBar)
    }
    
}
