//
//  LoginViewController.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Propriedades
    var webClient: DataProvider = SABERClient.shared
    var formChecker: FormCheckerDelegate = FormChecker()
    
    
    // MARK: - Outlets
    @IBOutlet weak var invalidKeyLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var keyTextField: UITextField!
    
    
    // MARK: - Actions
    @IBAction func login(_ sender: UIButton) {
        // ao fazer login é necessário gerar um token de acesso
        self.generateToken()
    }
    
    
    // MARK: - Ciclo de vida da View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.formChecker.setDelegate(for: [self.keyTextField],
                                     button: self.loginButton,
                                     barButton: nil)
    }
    
    
    // MARK: - Métodos do DataProvider
    func generateToken() {
        self.webClient.generateToken(from: self.keyTextField.text!) {
            token, error in
            self.waitAsyncRequest()
            if token != nil {
                self.performSegue(withIdentifier: "LoginToTopics",
                                  sender: self)
            } else if error != nil {
                PopUpDelegate.showNoNetworkPopup(on: self,
                                                 with: self.generateToken)
            } else {
                // mensagem de feedback ao usuário
                self.invalidKeyLabel.isHidden = false
            }
            self.activityIndicator.stopAnimating()
            self.loginButton.isEnabled = true
        }
    }
    
    
    // MARK: - Atualização da interface
    func waitAsyncRequest() {
        self.activityIndicator.startAnimating()
        self.loginButton.isEnabled = false
        self.invalidKeyLabel.isHidden = true
    }
}
