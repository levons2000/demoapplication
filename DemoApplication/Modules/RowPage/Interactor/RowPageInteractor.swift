import UIKit
import CoreData

class RowPageInteractor: NSObject, RowPageInteractorProtocol {
    
    var title: String = ""
    var content: String = ""
    var image: UIImage? = nil
    
    private static var instance: RowPageInteractor = {
        return RowPageInteractor()
    }()
    
    class var sharedInstance: RowPageInteractor {
        return instance
    }
    
    private override init() {
        
    }
    
    func addToFavorite() {
        let categoriesInteractor: CategoriesInteractor = CategoriesInteractor.sharedInstance
        let mainInteractor: MainInteractor = MainInteractor.sharedInstance
        
        
        switch categoriesInteractor.typeOfNew {
        
        case .some(.Sport):
            if !isExistsInDB(title: categoriesInteractor.sportDataArray[categoriesInteractor.indexOfNew].title!) {
                let entity = SavedNews(context: PersistenceService.context)
                entity.title = categoriesInteractor.sportDataArray[categoriesInteractor.indexOfNew].title
                entity.content = categoriesInteractor.sportDataArray[categoriesInteractor.indexOfNew].content
                let imageData: NSData = categoriesInteractor.sportImageArray[categoriesInteractor.indexOfNew]!.pngData()! as NSData
                entity.image = imageData
            }
        case .some(.Food):
            if !isExistsInDB(title: categoriesInteractor.foodDataArray[categoriesInteractor.indexOfNew].title!) {
                let entity = SavedNews(context: PersistenceService.context)
                entity.title = categoriesInteractor.foodDataArray[categoriesInteractor.indexOfNew].title
                entity.content = categoriesInteractor.foodDataArray[categoriesInteractor.indexOfNew].content
                let imageData: NSData = categoriesInteractor.foodImageArray[categoriesInteractor.indexOfNew]!.pngData()! as NSData
                entity.image = imageData
            }
        case .some(.Politics):
            if !isExistsInDB(title: categoriesInteractor.politicsDataArray[categoriesInteractor.indexOfNew].title!) {
                let entity = SavedNews(context: PersistenceService.context)
                entity.title = categoriesInteractor.politicsDataArray[categoriesInteractor.indexOfNew].title
                entity.content = categoriesInteractor.politicsDataArray[categoriesInteractor.indexOfNew].content
                let imageData: NSData = categoriesInteractor.politicsImageArray[categoriesInteractor.indexOfNew]!.pngData()! as NSData
                entity.image = imageData
            }
        case .some(.Tech):
            if !isExistsInDB(title: categoriesInteractor.techDataArray[categoriesInteractor.indexOfNew].title!) {
                let entity = SavedNews(context: PersistenceService.context)
                entity.title = categoriesInteractor.techDataArray[categoriesInteractor.indexOfNew].title
                entity.content = categoriesInteractor.techDataArray[categoriesInteractor.indexOfNew].content
                let imageData: NSData = categoriesInteractor.techImageArray[categoriesInteractor.indexOfNew]!.pngData()! as NSData
                entity.image = imageData
            }
        case .none:
            if !isExistsInDB(title: mainInteractor.mainDataArray[categoriesInteractor.indexOfNew].title!) {
                let entity = SavedNews(context: PersistenceService.context)
                entity.title = mainInteractor.mainDataArray[categoriesInteractor.indexOfNew].title
                entity.content = mainInteractor.mainDataArray[categoriesInteractor.indexOfNew].content
                let imageData: NSData = mainInteractor.mainImageArray[categoriesInteractor.indexOfNew]!.pngData()! as NSData
                entity.image = imageData
            }
        }
        PersistenceService.saveContext()
    }
    
    func isExistsInDB(title: String) -> Bool {
        var arrayOfSavedNews: Array<SavedNews> = Array()
        let fetchRequest: NSFetchRequest<SavedNews> = SavedNews.fetchRequest()
        do {
        let savedNews = try PersistenceService.context.fetch(fetchRequest)
            arrayOfSavedNews.append(contentsOf: savedNews)
        } catch {}
        
        for item in arrayOfSavedNews {
            if title == item.title {
                return true
            }
        }
        
        return false
    }
}
