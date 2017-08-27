//
//  AddTopicViewController.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

class AddTopicViewController: UIViewController {
    
    // MARK: - Properties
    var newTopic: NewPost?
    var formChecker: FormCheckerDelegate = FormChecker()
    

    // MARK: - Outlets
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        // uso de force unwrapping pois o FormCheckerDelegate
        // garante que haverá texto antes da ativação do botão
        self.newTopic = (title: self.titleTextField.text!,
                         message: self.messageTextView.text)
        
        self.performSegue(withIdentifier: "unwindToTopics",
                          sender: self)
        
    }
    
    
    // MARK: - Actions
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Ciclo de vida da View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.formChecker.setDelegate(for: [self.messageTextView, self.titleTextField],
                                     button: nil,
                                     barButton: self.saveButton)
        
        self.addBorder(to: self.messageTextView)

    }
    
    // MARK: - Customização da interface
    func addBorder(to textView: UITextView) {
        textView.layer.borderColor = Constant.Color.textViewBorder.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
    }
}
