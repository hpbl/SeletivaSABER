//
//  LoginViewController.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var keyTextField: UITextField!
    
    // MARK: - Properties
    var webClient: DataProvider = SABERClient()
    
    // MARK: - Actions
    @IBAction func login(_ sender: UIButton) {
        
        self.webClient.generateToken(from: self.keyTextField.text!) {
            token in
            
            if token != nil {
                self.performSegue(withIdentifier: "LoginToTopics",
                                  sender: self)
            } else {
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.keyTextField.delegate = self
        self.loginButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        self.loginButton.isEnabled = textField.hasText
    }
}
