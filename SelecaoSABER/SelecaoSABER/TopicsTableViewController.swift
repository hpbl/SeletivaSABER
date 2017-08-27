//
//  TopicsTableViewController.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit
import Alamofire

class TopicsTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet var topicsTableView: UITableView!
    
    // MARK: - Properties
    var topics: [Post] = [] {
        didSet {
            self.topicsTableView.reloadData()
        }
    }
    var webClient: DataProvider = SABERClient()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.topicsTableView.delegate = self
        self.topicsTableView.dataSource = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        

        self.getPosts()
    }
    
    // MARK: - Webservice requests
    func getPosts() {
        self.webClient.getPosts { returnedPosts, error in
            if let returnedPosts = returnedPosts {
                self.topics = returnedPosts
            } else if error != nil {
                PopUpDelegate.showNoNetworkPopup(on: self, with: self.getPosts)
            }
        }
    }
    
    func save(newPost: NewPost) {
        self.webClient.savePost(newPost: newPost,
                                callback: { (newId, error) in
                                    if newId != nil {
                                        self.getPosts()
                                    } else {
                                        PopUpDelegate.showSavingErrorPopop(on: self,
                                                                           for: newPost,
                                                                           with: self.save(newPost:))
                                    }
        })
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return self.topics.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicTableViewCell else {
            return UITableViewCell()
        }
        
        let currentTopic = self.topics[indexPath.row]
        
        cell.setupInterface(with: currentTopic)
        
        return cell

    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        switch segue.identifier {
        case "showTopicDetails"?:
            guard let detailsVC = segue.destination as? TopicDetailsViewController else {
                fatalError("expected segue destination to be of type TopicDetailsViewController")
            }
            
            guard let index = self.topicsTableView.indexPathForSelectedRow else {
                fatalError("couldn't find indexPath for selected row")
            }
            
            detailsVC.topic = self.topics[index.row]
            
        default:
            break
        }
    }
    
    
    @IBAction func unwindFromAddTopic(sender: UIStoryboardSegue) {
        
        if let addTopicVC = sender.source as? AddTopicViewController {
            if let newTopic = addTopicVC.newTopic {
                self.save(newPost: newTopic)
            }
        }
    }

}
