//
//  FormChecker.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 27/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

protocol FormCheckerDelegate: UITextViewDelegate, UITextFieldDelegate {
    
    var delegatedFields: [UIKeyInput] {set get}
    var delegatedButton: UIButton? {set get}
    var delegatedBarButton: UIBarButtonItem? {set get}

    
    func setDelegate(for fields: [UIKeyInput], button: UIButton?, barButton: UIBarButtonItem?) -> Void
    func checkFilledFields() -> Bool
}

extension FormCheckerDelegate {
    
    func setDelegate(for fields: [UIKeyInput], button: UIButton?, barButton: UIBarButtonItem?) {
        
        for inputField in fields {
            
            if let textField = inputField as? UITextField {
                textField.delegate = self
                self.delegatedFields.append(inputField)
            
            } else if let textView = inputField as? UITextView {
                textView.delegate = self
                self.delegatedFields.append(inputField)
            }
        }
        
        
        self.delegatedButton = button
        self.delegatedButton?.isEnabled = false
        
        self.delegatedBarButton = barButton
        self.delegatedBarButton?.isEnabled = false
    }
    
    func checkFilledFields() -> Bool {
        return self.delegatedFields.reduce(true, { (previousResult, inputField) -> Bool in
            return previousResult && inputField.hasText
        })
    }
}
