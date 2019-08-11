//
//  DetailViewController.swift
//  BookStore
//
//  Created by Karthik on 09/08/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

   

    @IBOutlet var detailTV: UITableView!
    
    let GETBook = GETBookAPIParser()
    
    var books : [Book]?
    let api = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTV.delegate = self
        detailTV.dataSource = self
        
        GETBook.getBooks()
    
        GETBook.reload = { [weak self] in
            self!.books = self!.GETBook.books
            DispatchQueue.main.async {
                self!.detailTV.reloadData()
            }
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
       let alert = UIAlertController(title: "Add a book", message: "Enter the book details", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
    
        alert.addTextField {
            $0.placeholder = "enter isbn"
        }
        alert.addTextField {
            $0.placeholder = "enter title"
        }
        alert.addTextField {
            $0.placeholder = "enter author"
        }
        alert.addTextField {
            $0.placeholder = "enter publisher"
        }
        alert.addTextField {
            $0.placeholder = "enter image"
        }
        let action = UIAlertAction(title: "Submit", style: UIAlertAction.Style.default) {
            _ in
            if     alert.textFields?[0].text == ""
                || alert.textFields?[1].text == ""
                || alert.textFields?[2].text == ""
                || alert.textFields?[3].text == ""
                || alert.textFields?[4].text == ""
            
            {
                return
            } else {
                self.api.postBookData(isbn: alert.textFields![0].text!, title: alert.textFields![1].text!, author: alert.textFields![2].text!, publisher: alert.textFields![3].text!, image: alert.textFields![4].text!) {
                    result in
                    print(result)
                }
            }
        }

        alert.addAction(action)
        alert.addAction(cancelAction)
        self.present(alert,animated: true,completion: nil)
    }
    
    @IBOutlet var addButton: UIButton!
}



extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("riches" )

        guard let books = books else { return 0 }
        print("success",books.count)
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailTableViewCell
        cell.title.text = books![indexPath.row].title
        cell.author.text = books![indexPath.row].author
        do {
        let url = URL(string: books![indexPath.row].image)
        let data = try Data(contentsOf: url!)
        cell.img.image = UIImage(data: data)
        cell.detailImg.image = UIImage(data: data)
        }
        catch {
            
        }
        return cell
    }
    
    
}
