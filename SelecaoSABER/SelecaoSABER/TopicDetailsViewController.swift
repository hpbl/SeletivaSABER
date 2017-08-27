//
//  TopicDetailsViewController.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

class TopicDetailsViewController: UIViewController {
    var comments: [Comment] = [] {
        didSet {
            self.detailsTableView.reloadData()
        }
    }
    var topic: Post!
    var webClient: DataProvider = SABERClient()
    var formChecker: FormCheckerDelegate = FormChecker()

    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func sendComment(_ sender: UIButton) {
        self.commentTextField.resignFirstResponder()
        
        
        if !self.commentTextField.text!.isEmpty {
            self.webClient.saveComment(message: self.commentTextField.text!,
                                       on: self.topic,
                                       callback: { (id, tid) in
                                        guard id != nil else {
                                            //TODO: TRATAR ERRO
                                            fatalError("não salvou o comentário")
                                        }
                                        
                                        self.commentTextField.text = ""
                                        self.getComments()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailsTableView.delegate = self
        self.detailsTableView.dataSource = self
        
        self.formChecker.setDelegate(for: [self.commentTextField],
                                     button: self.sendButton,
                                     barButton: nil)
        
        self.getComments()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getComments() {
        self.webClient.getComments(for: self.topic) { (comments, error) in
            if let comments = comments {
                self.comments = comments
            } else {
                PopUpDelegate.showNoNetworkPopup(on: self, with: self.getComments)
            }
        }
    }
}

extension TopicDetailsViewController: UITableViewDelegate,
                                      UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier: String
        var cellContent: Content
        
        if indexPath.row == 0  {
            cellIdentifier = "MessageCell"
            cellContent = self.topic
        } else {
            cellIdentifier = "CommentCell"
            cellContent = self.comments[indexPath.row - 1]
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContentCell else {
            return UITableViewCell()
        }
        
        cell.setupInterface(with: cellContent)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //var mockCell = UITableViewCell()
        var height: CGFloat = 0
        
        if indexPath.row == 0 {
            height = 150
        } else {
            height = 100
        }
        
        return height
    }
}
