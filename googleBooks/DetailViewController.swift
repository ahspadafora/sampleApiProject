//
//  DetailViewController.swift
//  googleBooks
//
//  Created by Amber Spadafora on 3/28/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    public var bookIndex: Int!
    public var currentBook: Book?
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(bookIndex)
        if let validBook = currentBook {
            self.bookTitleLabel.text = validBook.title
            self.authorLabel.text = validBook.authors[0]
        }
    }

    
    


}
