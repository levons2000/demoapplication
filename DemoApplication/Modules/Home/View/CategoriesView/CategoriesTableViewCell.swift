import UIKit

class CategoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    
    
    @IBOutlet weak var newsContent: UITextView!
    
    @IBOutlet weak var newsFavoriteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
