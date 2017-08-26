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

    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text else {
            fatalError("preencha um título")
        }
        
        if !title.isEmpty &&
            !self.messageTextView.text.isEmpty {
            
            self.newTopic = (title: title,
                             message: self.messageTextView.text)
            
            self.performSegue(withIdentifier: "unwindToTopics",
                              sender: self)
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
