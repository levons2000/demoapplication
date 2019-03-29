//
//  MainInteractor.swift
//  DemoApplication
//
//  Created by levon on 3/18/19.
//  Copyright © 2019 name. All rights reserved.
//

import UIKit

class MainInteractor: NSObject, MainInteractorProtocol {
    
    
    var dataArray = Array<Articles>()
    var imageArray = Array<UIImage?>()
    
    var indexOfNew = 0
    
    private static var instance: MainInteractor = {
        return MainInteractor()
    }()
    
    class var sharedInstance: MainInteractor {
        return instance
    }
    
    private override init() {
    
    }
    
    func initTableViewItem(url: URL, tableView: UITableView) {
        dataArray.removeAll()
        imageArray.removeAll()
        tableView.reloadData()
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let newsModel = try JSONDecoder().decode(NewsModel.self, from: data)
                let array = newsModel.articles!
                for article in array {
                    self.dataArray.append(article)
                    if article.urlToImage != nil {
                       self.downloadImage(from: URL(string: article.urlToImage!), tableView: tableView)
                    } else {
                        self.imageArray.append(nil)
                        DispatchQueue.main.async{
                            if ((self.imageArray.count == self.dataArray.count / 2) || (self.imageArray.count == self.dataArray.count)) {
                                tableView.reloadData()
                            }
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            }.resume()
    }
    
    func downloadImage(from url: URL?, tableView: UITableView) {
        if url != nil {
            getData(from: url!) { data, response, error in
                guard let data = data, error == nil else {
                    self.imageArray.append(nil)
                    return
                }
                self.imageArray.append(UIImage(data: data))
                DispatchQueue.main.async{
                    if ((self.imageArray.count == self.dataArray.count / 2) || (self.imageArray.count == self.dataArray.count)) {
                        tableView.reloadData()
                    }
                }
            }
        } else {
            self.imageArray.append(nil)
            DispatchQueue.main.async{
                if ((self.imageArray.count == self.dataArray.count / 2) || (self.imageArray.count == self.dataArray.count)) {
                    tableView.reloadData()
                }
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func deleteData() {
        dataArray.removeAll()
        imageArray.removeAll()
    }
    
}
