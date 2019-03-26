//
//  NewsTableViewCell.swift
//  DemoApplication
//
//  Created by levon on 3/18/19.
//  Copyright © 2019 name. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsContent: UITextView!
    @IBOutlet weak var newsFavorite: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
