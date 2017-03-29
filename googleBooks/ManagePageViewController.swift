//
//  ManagePageViewController.swift
//  googleBooks
//
//  Created by Amber Spadafora on 3/28/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {
    var books: [Book] = []
    var currentIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(books.count)
        self.dataSource = self
        
        if let detailVC = viewBookDetailController(index: currentIndex ?? 0) {
            let viewControllers = [detailVC]
            setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        }
        
    }
    
    func viewBookDetailController(index: Int) -> DetailViewController? {
        if let storyboard = storyboard,
            let page = storyboard.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController {
            page.bookIndex = index
            print(self.books[index].title)
            let _ = page.view
            page.bookTitleLabel.text = self.books[index].title
            page.authorLabel.text = self.books[index].authors[0]
            page.summaryLabel.text = self.books[index].description
            
            if let validUrl = URL(string: self.books[index].smallThumbnail!) {
                let currentSession = URLSession(configuration: .default)
                currentSession.dataTask(with: validUrl, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error!)
                    }
                    if let validData = data {
                        page.bookImage.image = UIImage(data: validData)
                    }
                })
                    .resume()
            }
            
            return page
        }
        return nil
    }
}

extension ManagePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let vc = viewController as? DetailViewController {
            var index = vc.bookIndex
            guard index != NSNotFound && index != 0 else { return nil }
            index = index! - 1
            return viewBookDetailController(index: index!)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let vc = viewController as? DetailViewController {
            var index = vc.bookIndex
            guard index != NSNotFound else { return nil }
            index = index! + 1
            guard index != books.count else { return nil }
            return viewBookDetailController(index: index!)
        }
        return nil
    }
}
