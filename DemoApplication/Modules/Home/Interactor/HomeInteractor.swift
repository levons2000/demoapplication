import UIKit

class HomeInteractor: NSObject, HomeInteractorProtocol {
    
    var dataArray: Array<Articles> = Array()
    var imageArray: Array<UIImage?> = Array()
    
    let categoriesInteractor: CategoriesInteractor = CategoriesInteractor.sharedInstance
    let mainInteractor: MainInteractor = MainInteractor.sharedInstance
    
    private static var instance: HomeInteractor = {
        return HomeInteractor()
    }()
    
    class var sharedInstance: HomeInteractor {
        return instance
    }
    
    private override init() {
        
    }
    
    func initTableView(tableView: UITableView, progressBar: UIActivityIndicatorView, urlString: String) {
        dataArray.removeAll()
        imageArray.removeAll()
        tableView.isHidden = true
        progressBar.startAnimating()
        progressBar.hidesWhenStopped = true
        tableView.reloadData()
        if !checkIsDataEmpty() {
            progressBar.stopAnimating()
            tableView.isHidden = false
            return
        }
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let newsModel = try JSONDecoder().decode(NewsModel.self, from: data)
                let array = newsModel.articles!
                for article in array {
                    self.dataArray.append(article)
                    if article.urlToImage != nil {
                        self.downloadImage(from: URL(string: article.urlToImage!), tableView: tableView, progressBar: progressBar)
                    } else {
                        self.imageArray.append(nil)
                        DispatchQueue.main.async{
                            if (self.imageArray.count == self.dataArray.count) {
                                switch self.categoriesInteractor.typeOfNew {
                                case .some(.Sport):
                                    self.categoriesInteractor.sportDataArray.append(contentsOf: self.dataArray)
                                    self.categoriesInteractor.sportImageArray.append(contentsOf: self.imageArray)
                                case .some(.Food):
                                    self.categoriesInteractor.foodDataArray.append(contentsOf: self.dataArray)
                                    self.categoriesInteractor.foodImageArray.append(contentsOf: self.imageArray)
                                case .some(.Politics):
                                    self.categoriesInteractor.politicsDataArray.append(contentsOf: self.dataArray)
                                    self.categoriesInteractor.politicsImageArray.append(contentsOf: self.imageArray)
                                case .some(.Tech):
                                    self.categoriesInteractor.techDataArray.append(contentsOf: self.dataArray)
                                    self.categoriesInteractor.techImageArray.append(contentsOf: self.imageArray)
                                case .none:
                                    self.mainInteractor.mainDataArray.append(contentsOf: self.dataArray)
                                    self.mainInteractor.mainImageArray.append(contentsOf: self.imageArray)
                                }
                                tableView.reloadData()
                                progressBar.stopAnimating()
                                tableView.isHidden = false
                            }
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            }.resume()
    }
    
    func downloadImage(from url: URL?, tableView: UITableView, progressBar: UIActivityIndicatorView) {
        if url != nil {
            getData(from: url!) { data, response, error in
                guard let data = data, error == nil else {
                    self.imageArray.append(nil)
                    return
                }
                self.imageArray.append(UIImage(data: data))
                DispatchQueue.main.async{
                    if (self.imageArray.count == self.dataArray.count) {
                        switch self.categoriesInteractor.typeOfNew {
                        case .some(.Sport):
                            self.categoriesInteractor.sportDataArray.append(contentsOf: self.dataArray)
                            self.categoriesInteractor.sportImageArray.append(contentsOf: self.imageArray)
                        case .some(.Food):
                            self.categoriesInteractor.foodDataArray.append(contentsOf: self.dataArray)
                            self.categoriesInteractor.foodImageArray.append(contentsOf: self.imageArray)
                        case .some(.Politics):
                            self.categoriesInteractor.politicsDataArray.append(contentsOf: self.dataArray)
                            self.categoriesInteractor.politicsImageArray.append(contentsOf: self.imageArray)
                        case .some(.Tech):
                            self.categoriesInteractor.techDataArray.append(contentsOf: self.dataArray)
                            self.categoriesInteractor.techImageArray.append(contentsOf: self.imageArray)
                        case .none:
                            self.mainInteractor.mainDataArray.append(contentsOf: self.dataArray)
                            self.mainInteractor.mainImageArray.append(contentsOf: self.imageArray)
                        }
                        tableView.reloadData()
                        progressBar.stopAnimating()
                        tableView.isHidden = false
                    }
                }
            }
        } else {
            self.imageArray.append(nil)
            DispatchQueue.main.async{
                if (self.imageArray.count == self.dataArray.count) {
                    switch self.categoriesInteractor.typeOfNew {
                    case .some(.Sport):
                        self.categoriesInteractor.sportDataArray.append(contentsOf: self.dataArray)
                        self.categoriesInteractor.sportImageArray.append(contentsOf: self.imageArray)
                    case .some(.Food):
                        self.categoriesInteractor.foodDataArray.append(contentsOf: self.dataArray)
                        self.categoriesInteractor.foodImageArray.append(contentsOf: self.imageArray)
                    case .some(.Politics):
                        self.categoriesInteractor.politicsDataArray.append(contentsOf: self.dataArray)
                        self.categoriesInteractor.politicsImageArray.append(contentsOf: self.imageArray)
                    case .some(.Tech):
                        self.categoriesInteractor.techDataArray.append(contentsOf: self.dataArray)
                        self.categoriesInteractor.techImageArray.append(contentsOf: self.imageArray)
                    case .none:
                        self.mainInteractor.mainDataArray.append(contentsOf: self.dataArray)
                        self.mainInteractor.mainImageArray.append(contentsOf: self.imageArray)
                    }
                    tableView.reloadData()
                    progressBar.stopAnimating()
                    tableView.isHidden = false
                }
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func checkIsDataEmpty() -> Bool {
        switch categoriesInteractor.typeOfNew {
        case .some(.Sport):
            return categoriesInteractor.sportImageArray.count == 0
        case .some(.Food):
            return categoriesInteractor.foodImageArray.count == 0
        case .some(.Politics):
            return categoriesInteractor.politicsImageArray.count == 0
        case .some(.Tech):
            return categoriesInteractor.techImageArray.count == 0
        case .none:
            return mainInteractor.mainImageArray.count == 0
        }
    }
}
