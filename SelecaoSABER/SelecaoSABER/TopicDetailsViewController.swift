//
//  TopicDetailsViewController.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

class TopicDetailsViewController: UIViewController {
    var comments: [Comment] = []
    var topics: [Post] = []
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailsTableView.delegate = self
        self.detailsTableView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TopicDetailsViewController: UITableViewDelegate,
UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count + self.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier: String
        var cellContent: Content
        
        if indexPath.row < self.topics.count  {
            cellIdentifier = "MessageCell"
            cellContent = self.topics[indexPath.row]
        } else {
            cellIdentifier = "CommentCell"
            cellContent = self.comments[indexPath.row - self.topics.count]
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContentCell else {
            fatalError("Célula de tipo inesperado")
        }
        
        cell.setupInterface(with: cellContent)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //var mockCell = UITableViewCell()
        var height: CGFloat = 0
        
        if indexPath.row < self.topics.count  {
            height = 150
        } else {
            height = 100
        }
        
        return height
    }
}
