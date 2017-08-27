//
//  AddTopicViewController.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

class AddTopicViewController: UIViewController {
    
    var newTopic: (title: String, message: String)?

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        self.newTopic = (title: self.titleTextField.text!,
                         message: self.messageTextView.text)
        
        self.performSegue(withIdentifier: "unwindToTopics",
                          sender: self)
        
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messageTextView.delegate = self
        self.titleTextField.delegate = self
        self.saveButton.isEnabled = false
    }
    
    func completedFillingFields() -> Bool {
        return self.titleTextField.hasText && self.messageTextView.hasText
    }
}

extension AddTopicViewController: UITextViewDelegate {

    func textViewDidEndEditing(_ textView: UITextView) {
        self.saveButton.isEnabled = self.completedFillingFields()
    }
}

extension AddTopicViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.saveButton.isEnabled = self.completedFillingFields()
    }
}
