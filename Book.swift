//
//  Book.swift
//  googleBooks
//
//  Created by Amber Spadafora on 3/28/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation

class Book {
    
    let bookID: String
    let title: String
    let authors: [String]
    let smallThumbnail: String?
    let description: String?
    
    init(bookID: String, title: String, authors: [String], smallThumbnail: String?, description: String?) {
        self.bookID = bookID
        self.title = title
        self.authors = authors
        self.smallThumbnail = smallThumbnail
        self.description = description
    }
    
}
