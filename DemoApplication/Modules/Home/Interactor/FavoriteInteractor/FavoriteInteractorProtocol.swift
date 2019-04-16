import Foundation

@objc protocol FavoriteInteractorProtocol {
    func initDataFromDB(tableView: UITableView, progressBar: UIActivityIndicatorView)
}
