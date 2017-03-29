//
//  BookTableViewCell.swift
//  googleBooks
//
//  Created by Amber Spadafora on 3/28/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var currentBook: Book?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
