import UIKit
import CoreData

class FavoriteInteractor: NSObject, FavoriteInteractorProtocol {
    var favoriteArray: Array<SavedNews> = Array()
    
    private static var instance: FavoriteInteractor = {
        return FavoriteInteractor()
    }()
    
    class var sharedInstance: FavoriteInteractor {
        return instance
    }
    
    private override init() {
        
    }
    
    func initDataFromDB(tableView: UITableView, progressBar: UIActivityIndicatorView) {
        let fetchRequest: NSFetchRequest<SavedNews> = SavedNews.fetchRequest()
        do {
            let savedNews = try PersistenceService.context.fetch(fetchRequest)
            favoriteArray.append(contentsOf: savedNews)
            progressBar.hidesWhenStopped = true
            progressBar.stopAnimating()
            if self.favoriteArray.count != 0 {
                tableView.reloadData()
                tableView.isHidden = false
            } else {
                tableView.isHidden = true
            }
        } catch {
            print("Problems with data fetching")
        }
    }
    
    func initFavoriteTableView(progressBar: UIActivityIndicatorView, tableView: UITableView) {
        favoriteArray.removeAll()
        tableView.isHidden = true
        progressBar.startAnimating()
        initDataFromDB(tableView: tableView, progressBar: progressBar)
    }
}
