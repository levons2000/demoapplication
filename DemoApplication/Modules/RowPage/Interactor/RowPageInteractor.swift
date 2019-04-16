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
        let entity = SavedNews(context: PersistenceService.context)
        switch categoriesInteractor.typeOfNew {
        case .some(.Sport):
            entity.title = categoriesInteractor.sportDataArray[categoriesInteractor.indexOfNew].title
            entity.content = categoriesInteractor.sportDataArray[categoriesInteractor.indexOfNew].content
            let imageData: NSData = categoriesInteractor.sportImageArray[categoriesInteractor.indexOfNew]!.pngData()! as NSData
            entity.image = imageData
        case .some(.Food):
            entity.title = categoriesInteractor.foodDataArray[categoriesInteractor.indexOfNew].title
            entity.content = categoriesInteractor.foodDataArray[categoriesInteractor.indexOfNew].content
            let imageData: NSData = categoriesInteractor.foodImageArray[categoriesInteractor.indexOfNew]!.pngData()! as NSData
            entity.image = imageData
        case .some(.Politics):
            entity.title = categoriesInteractor.politicsDataArray[categoriesInteractor.indexOfNew].title
            entity.content = categoriesInteractor.politicsDataArray[categoriesInteractor.indexOfNew].content
            let imageData: NSData = categoriesInteractor.politicsImageArray[categoriesInteractor.indexOfNew]!.pngData()! as NSData
            entity.image = imageData
        case .some(.Tech):
            entity.title = categoriesInteractor.techDataArray[categoriesInteractor.indexOfNew].title
            entity.content = categoriesInteractor.techDataArray[categoriesInteractor.indexOfNew].content
            let imageData: NSData = categoriesInteractor.techImageArray[categoriesInteractor.indexOfNew]!.pngData()! as NSData
            entity.image = imageData
        case .none:
            entity.title = mainInteractor.mainDataArray[categoriesInteractor.indexOfNew].title
            entity.content = mainInteractor.mainDataArray[categoriesInteractor.indexOfNew].content
            let imageData: NSData = mainInteractor.mainImageArray[categoriesInteractor.indexOfNew]!.pngData()! as NSData
            entity.image = imageData
        }
        PersistenceService.saveContext()
    }
}
