//
//  TopicDetailsViewController.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

class TopicDetailsViewController: UIViewController {
    
    // MARK: - Properties
    var comments: [Comment] = [] {
        didSet {
            self.detailsTableView.reloadData()
        }
    }
    var topic: Post!
    var webClient: DataProvider = SABERClient.shared
    var formChecker: FormCheckerDelegate = FormChecker()

    
    // MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    
    // MARK: - Actions
    @IBAction func sendComment(_ sender: UIButton) {
        self.commentTextField.resignFirstResponder()
        
        // apenas são alvos comentários não vazios
        // nese caso utilizamos force unwrapping
        // pois temos certeza que existe texto (FormCheckerDelegate)
        if !self.commentTextField.text!.isEmpty {
            let newComment = (message: self.commentTextField.text!, post: self.topic!)
                self.save(newComment: newComment)
        }
    }
    
    
    // MARK: - Ciclo de vida da View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailsTableView.delegate = self
        self.detailsTableView.dataSource = self
        
        self.formChecker.setDelegate(for: [self.commentTextField],
                                     button: self.sendButton,
                                     barButton: nil)
        
        self.getComments()
    }
    

    // MARK: - Métodos do DataProvider
    func getComments() {
        self.activityIndicator.startAnimating()

        self.webClient.getComments(for: self.topic) { (comments, error) in

            if let comments = comments {
                self.comments = comments
            } else {
                PopUpDelegate.showNoNetworkPopup(on: self, with: self.getComments)
            }
            
            self.activityIndicator.stopAnimating()
        }
    }
    
    func save(newComment: NewComment) {
        self.activityIndicator.startAnimating()

        self.webClient.saveComment(newComment: newComment,
                                   callback: { (id, tid, error) in
                                    if id != nil {
                                        self.commentTextField.text = ""
                                        self.getComments()
                                        
                                    } else {
                                        PopUpDelegate.showSavingErrorPopop(on: self,
                                                                           for: newComment,
                                                                           with: self.save(newComment:))
                                    }
                                    self.activityIndicator.stopAnimating()

                                    
                                    
        })
    }
}


// MARK: - Métodos da Table View
extension TopicDetailsViewController: UITableViewDelegate,
                                      UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // o +1 leva em consideração o tópico
        return self.comments.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // de acordo com a posição atual,
        // definimos o tipo de célula
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
        
        // Tamanhos diferentes para cada tipo de célula
        var height: CGFloat = 0
        
        if indexPath.row == 0 {
            // valor definido no storyBoard
            height = 150
        } else {
            // valor definido no storyBoard
            height = 100
        }
        
        return height
    }
}
