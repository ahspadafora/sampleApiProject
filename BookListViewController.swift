//
//  BookListViewController.swift
//  googleBooks
//
//  Created by Amber Spadafora on 3/28/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {
    
    var books: [Book] = []
    
    @IBOutlet weak var bookListTableView: UITableView!
    @IBOutlet weak var bookSearchBar: UISearchBar!
    
    override func viewDidAppear(_ animated: Bool) {
        bookListTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? BookTableViewCell,
            let indexPath = bookListTableView.indexPath(for: cell),
            let managePageViewController = segue.destination as? ManagePageViewController {
            managePageViewController.books = self.books
            managePageViewController.currentIndex = indexPath.row
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bookListTableView.dataSource = self
        bookListTableView.delegate = self
        
        bookListTableView.rowHeight = UITableViewAutomaticDimension
        bookListTableView.estimatedRowHeight = 150
        
        bookSearchBar.delegate = self
        DispatchQueue.main.async {
            self.getBookData()
            self.bookListTableView.reloadData()
        }
        
    }
    
    fileprivate func getBookData(){
        APIManager.shared.getBookData(searchTerm: "dog") { (books) in
            DispatchQueue.main.async {
                self.books = books as! [Book]
                self.bookListTableView.reloadData()
                self.bookListTableView.setNeedsLayout()
                print(self.books.count)
            }
        }
    }
    
    
    
}

extension BookListViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BookTableViewCell = bookListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookTableViewCell
        
        let currentBook = books[indexPath.row]
        cell.titleLabel.text = currentBook.title
        cell.authorLabel.text = currentBook.authors[0]
        
        DispatchQueue.main.async {
            if let imageUrl = URL(string: (currentBook.smallThumbnail)!) {
                let currentSession = URLSession(configuration: .default)
                currentSession.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error!)
                    }
                    if let validData = data {
                        if let cellToUpdate: BookTableViewCell = self.bookListTableView?.cellForRow(at: indexPath) as? BookTableViewCell,
                            cellToUpdate.bookImageView.image == nil {
                            cellToUpdate.bookImageView.image = UIImage(data: validData) // will work fine even if image is nil
                            cellToUpdate.setNeedsLayout() // need to reload the view, which won't happen otherwise since this is in an async call
                        }
                    }
                })
                    .resume()
            }
            
        }
        return cell
    }
    
}

extension BookListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text {
            let formattedTerm = searchTerm.replacingOccurrences(of: " ", with: "_")
            APIManager.shared.getBookData(searchTerm: formattedTerm) { (books) in
                DispatchQueue.main.async {
                    self.books = books as! [Book]
                    self.bookListTableView.reloadData()
                }
            }
        }
    }
    
}
