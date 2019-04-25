import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsContent: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var tableView: UITableView? = nil
    var indexOfFavorite = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        let favoriteInteractor: FavoriteInteractor = FavoriteInteractor.sharedInstance
        PersistenceService.context.delete(favoriteInteractor.favoriteArray[indexOfFavorite])
        PersistenceService.saveContext()
            favoriteInteractor.favoriteArray.remove(at: indexOfFavorite)
        if (favoriteInteractor.favoriteArray.count == 0) {
            tableView?.isHidden = true
        }
        tableView?.reloadData()
    }
    
}
