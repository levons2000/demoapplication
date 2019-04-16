import UIKit

class MainInteractor: NSObject, MainInteractorProtocol {
    
    var mainDataArray = Array<Articles>()
    var mainImageArray = Array<UIImage?>()
    
    var indexOfNew = 0
    
    private static var instance: MainInteractor = {
        return MainInteractor()
    }()
    
    class var sharedInstance: MainInteractor {
        return instance
    }
    
    private override init() {
    
    }
    
    func initMainTableView(tableView: UITableView, progressBar: UIActivityIndicatorView) {
        let homeInteractor: HomeInteractor = HomeInteractor.sharedInstance
        homeInteractor.dataArray = mainDataArray
        homeInteractor.imageArray = mainImageArray
        homeInteractor.initTableView(tableView: tableView, progressBar: progressBar,
                                     urlString: APIURL)
    }
    
    func deleteData() {
        mainDataArray.removeAll()
        mainImageArray.removeAll()
    }
    
}
