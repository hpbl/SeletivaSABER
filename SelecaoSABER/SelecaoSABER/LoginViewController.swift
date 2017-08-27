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
    @IBOutlet weak var invalidKeyLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var keyTextField: UITextField!
    
    // MARK: - Properties
    var webClient: DataProvider = SABERClient()
    var formChecker: FormCheckerDelegate = FormChecker()
    
    // MARK: - Actions
    @IBAction func login(_ sender: UIButton) {
        
        self.webClient.generateToken(from: self.keyTextField.text!) {
            token in
            self.waitAsyncRequest()
            if token != nil {
                self.finishedWaiting(true)
                self.performSegue(withIdentifier: "LoginToTopics",
                                  sender: self)
            } else {
                self.finishedWaiting(false)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.formChecker.setDelegate(for: [self.keyTextField],
                                     button: self.loginButton,
                                     barButton: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func waitAsyncRequest() {
        self.activityIndicator.startAnimating()
        self.loginButton.isEnabled = false
        self.invalidKeyLabel.isHidden = true
    }
    
    func finishedWaiting(_ success: Bool) {
        self.activityIndicator.stopAnimating()
        
        if !success {
            self.loginButton.isEnabled = true
            self.invalidKeyLabel.isHidden = false
        }
    }
}
