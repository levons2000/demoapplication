import UIKit

class CollapsingTableViewController: UITableViewController, CollapsingTableViewControllerProtocol {
    
    let mainInteractor: MainInteractor = MainInteractor.sharedInstance
    let categoriesInteractor: CategoriesInteractor = CategoriesInteractor.sharedInstance
    let favoriteInteractor: FavoriteInteractor = FavoriteInteractor.sharedInstance
    
    let rowPageWireframe: RowPageWireframe = RowPageWireframe.sharedInstance
    
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsContent: UITextView!
    
    var headerView: UIView!
    var newHeaderLayer: CAShapeLayer!
    
    private let headerHeight: CGFloat = 250
    private let headerCut: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    
    func initData() {
        var newsDescription: String = ""
        if categoriesInteractor.isFavorite {
            if favoriteInteractor.favoriteArray[mainInteractor.indexOfNew].image != nil {
                newsImage.image = UIImage(data: favoriteInteractor.favoriteArray[mainInteractor.indexOfNew].image! as Data)
            }
            newsDescription = favoriteInteractor.favoriteArray[mainInteractor.indexOfNew].content!
        } else {
        if categoriesInteractor.typeOfNew == nil {
            newsImage.image = mainInteractor.mainImageArray[categoriesInteractor.indexOfNew]
            if mainInteractor.mainDataArray[categoriesInteractor.indexOfNew].description != nil {
                newsDescription = mainInteractor.mainDataArray[categoriesInteractor.indexOfNew].description!
            }
        } else {
            switch categoriesInteractor.typeOfNew {
            case .some(.Sport):
                newsImage.image = categoriesInteractor.sportImageArray[categoriesInteractor.indexOfNew]
                if categoriesInteractor.sportDataArray[categoriesInteractor.indexOfNew].description != nil {
                    newsDescription = categoriesInteractor.sportDataArray[categoriesInteractor.indexOfNew].description!
                }
            case .some(.Food):
                newsImage.image = categoriesInteractor.foodImageArray[categoriesInteractor.indexOfNew]
                if categoriesInteractor.foodDataArray[categoriesInteractor.indexOfNew].description != nil {
                    newsDescription = categoriesInteractor.foodDataArray[categoriesInteractor.indexOfNew].description!
                }
            case .some(.Politics):
                newsImage.image = categoriesInteractor.politicsImageArray[categoriesInteractor.indexOfNew]
                if categoriesInteractor.politicsDataArray[categoriesInteractor.indexOfNew].description != nil {
                    newsDescription = categoriesInteractor.politicsDataArray[categoriesInteractor.indexOfNew].description!
                }
            case .some(.Tech):
                newsImage.image = categoriesInteractor.techImageArray[categoriesInteractor.indexOfNew]
                if categoriesInteractor.techDataArray[categoriesInteractor.indexOfNew].description != nil {
                    newsDescription = categoriesInteractor.techDataArray[categoriesInteractor.indexOfNew].description!
                }
            case .none:
                break
            }
        }
        }
        
        if newsDescription != "" {
            for _ in 0...2 {
                newsDescription += newsDescription
            }
        }
        newsContent.text = newsDescription
        self.updateView()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func updateView() {
        tableView.backgroundColor = UIColor.white
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(headerView)
        newHeaderLayer = CAShapeLayer()
        newHeaderLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = newHeaderLayer
        let newHeight = headerHeight - headerCut / 2
        tableView.contentInset = UIEdgeInsets(top: newHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -newHeight)
        self.setupNewView()
    }
    
    func setupNewView() {
        let newHeight = headerHeight - headerCut / 2
        var getHeaderFrame = CGRect(x: 0, y: -newHeight, width: tableView.bounds.width, height: headerHeight)
        if tableView.contentOffset.y < newHeight {
            getHeaderFrame.origin.y = tableView.contentOffset.y
            getHeaderFrame.size.height = -tableView.contentOffset.y + headerCut / 2
        }
        headerView.frame = getHeaderFrame
        let cutDirection = UIBezierPath()
        cutDirection.move(to: CGPoint(x: 0, y: 0))
        cutDirection.addLine(to: CGPoint(x: getHeaderFrame.width, y: 0))
        cutDirection.addLine(to: CGPoint(x: getHeaderFrame.width, y: getHeaderFrame.height))
        cutDirection.addLine(to: CGPoint(x: 0, y: getHeaderFrame.height - headerCut))
        newHeaderLayer.path = cutDirection.cgPath
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tableView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.setupNewView()
        var offset = scrollView.contentOffset.y / 150
        if offset > -0.5 {
            UIView.animate(withDuration: 0.2) {
                offset = 1
                let color = UIColor(red: 0.1294, green: 0.5882, blue: 0.9529, alpha: offset)
                //let navigationColor = UIColor.blue
                //self.navigationController?.navigationBar.tintColor = navigationColor
                self.navigationController?.navigationBar.backgroundColor = color
                UIApplication.shared.statusBarView?.backgroundColor = color
                //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: navigationColor]
                self.navigationController?.navigationBar.barStyle = .default
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
                self.navigationController?.navigationBar.tintColor = UIColor.white
                self.navigationController?.navigationBar.backgroundColor = color
                UIApplication.shared.statusBarView?.backgroundColor = color
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                self.navigationController?.navigationBar.barStyle = .black
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        let wireframe:LoginWireframe = LoginWireframe.sharedInstance
        wireframe.presentHomeScreen()
    }
    
}
