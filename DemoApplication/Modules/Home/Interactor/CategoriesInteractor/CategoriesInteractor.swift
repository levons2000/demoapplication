import UIKit

class CategoriesInteractor: NSObject, CategoriesInteractorProtocol {

    var sportDataArray = Array<Articles>()
    var sportImageArray = Array<UIImage?>()
    
    var foodDataArray = Array<Articles>()
    var foodImageArray = Array<UIImage?>()
    
    var politicsDataArray = Array<Articles>()
    var politicsImageArray = Array<UIImage?>()
    
    var techDataArray = Array<Articles>()
    var techImageArray = Array<UIImage?>()
    
    var indexOfNew = 0
    var typeOfNew: NewsType? = nil
    var isFavorite: Bool = false
    
    var isClear = false
    
    private static var instance: CategoriesInteractor = {
        return CategoriesInteractor()
    }()
    
    class var sharedInstance: CategoriesInteractor {
        return instance
    }
    
    private override init() {
        
    }
    
    func initCategoriesTableView(tableView: UITableView, progressBar: UIActivityIndicatorView) {
        var urlString: String
        let homeInteractor: HomeInteractor = HomeInteractor.sharedInstance
        switch typeOfNew {
        case .some(.Sport):
            urlString = SPORTAPIURL
            homeInteractor.dataArray = sportDataArray
            homeInteractor.imageArray = sportImageArray
            homeInteractor.initTableView(tableView: tableView, progressBar: progressBar,
                                         urlString: urlString)
        case .some(.Food):
            urlString = FOODAPIURL
            homeInteractor.dataArray = foodDataArray
            homeInteractor.imageArray = foodImageArray
            homeInteractor.initTableView(tableView: tableView, progressBar: progressBar,
                                         urlString: urlString)
        case .some(.Politics):
            urlString = POLITICSAPIURL
            homeInteractor.dataArray = politicsDataArray
            homeInteractor.imageArray = politicsImageArray
            homeInteractor.initTableView(tableView: tableView, progressBar: progressBar,
                                         urlString: urlString)
        case .some(.Tech):
            urlString = TECHAPIURL
            homeInteractor.dataArray = techDataArray
            homeInteractor.imageArray = techImageArray
            homeInteractor.initTableView(tableView: tableView, progressBar: progressBar,
                                         urlString: urlString)
        case .none:
            break
        }
        
    }
    
    func deleteData(typeOfNew: NewsType) {
        switch typeOfNew {
        case .Sport:
            sportDataArray.removeAll()
            sportImageArray.removeAll()
        case .Food:
            foodDataArray.removeAll()
            foodImageArray.removeAll()
        case .Politics:
            politicsDataArray.removeAll()
            politicsImageArray.removeAll()
        case .Tech:
            techDataArray.removeAll()
            techImageArray.removeAll()
      
        }
    }
}
