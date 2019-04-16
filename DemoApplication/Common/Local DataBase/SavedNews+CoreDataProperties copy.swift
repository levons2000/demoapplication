import Foundation
import CoreData

extension SavedNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedNews> {
        return NSFetchRequest<SavedNews>(entityName: "SavedNews")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var image: NSData?

}
