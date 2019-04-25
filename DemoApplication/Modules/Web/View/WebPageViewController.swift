import UIKit

class WebPageViewController: UIViewController, WebPageViewControllerProtocol {    
    
    let mainInteractor: MainInteractor = MainInteractor.sharedInstance
    let categoriesInteractor: CategoriesInteractor = CategoriesInteractor.sharedInstance
    
    @IBOutlet weak var webPage: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if categoriesInteractor.typeOfNew == nil {
            if mainInteractor.mainDataArray[categoriesInteractor.indexOfNew].url != nil {
                loadWebView(urlString: mainInteractor.mainDataArray[categoriesInteractor.indexOfNew].url!)
            }
        } else {
            switch categoriesInteractor.typeOfNew {
            case .some(.Sport):
                if categoriesInteractor.sportDataArray[categoriesInteractor.indexOfNew].url != nil {
                    loadWebView(urlString: categoriesInteractor.sportDataArray[categoriesInteractor.indexOfNew].url!)
                }
            case .some(.Food):
                if categoriesInteractor.foodDataArray[categoriesInteractor.indexOfNew].url != nil {
                    loadWebView(urlString: categoriesInteractor.foodDataArray[categoriesInteractor.indexOfNew].url!)
                }
            case .some(.Politics):
                if categoriesInteractor.politicsDataArray[categoriesInteractor.indexOfNew].url != nil {
                    loadWebView(urlString: categoriesInteractor.politicsDataArray[categoriesInteractor.indexOfNew].url!)
                }
            case .some(.Tech):
                if categoriesInteractor.techDataArray[categoriesInteractor.indexOfNew].url != nil {
                    loadWebView(urlString: categoriesInteractor.techDataArray[categoriesInteractor.indexOfNew].url!)
                }
            case .none:
                break
            }
        }
    }
    
    func loadWebView(urlString: String) {
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        webPage.loadRequest(urlRequest)
    }
    
    @IBAction func backButton(_ sender: Any) {
        let wireframe: LoginWireframe = LoginWireframe.sharedInstance
        wireframe.presentHomeScreen()
    }
}
