//
//  FormChecker.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 27/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

// protocolo onde definimos métodos para ativar botões
// apenas quando o conteúdo textual do formulário for preenchido
protocol FormCheckerDelegate: UITextViewDelegate, UITextFieldDelegate {
    
    var delegatedFields: [UIKeyInput] {set get}
    var delegatedButton: UIButton? {set get}
    var delegatedBarButton: UIBarButtonItem? {set get}

    
    func setDelegate(for fields: [UIKeyInput], button: UIButton?, barButton: UIBarButtonItem?) -> Void
    func checkFilledFields() -> Bool
}

extension FormCheckerDelegate {
    
    // abstrai chamadas de .delegate = self dos view controllers,
    // e desativação dos botoões
    func setDelegate(for fields: [UIKeyInput], button: UIButton?, barButton: UIBarButtonItem?) {
        
        for inputField in fields {
            // TODO: Fazer com o que o protocolo funcione com qualquer UIKeyInput
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
    
    //confere se todos os campos foram preenchidos
    func checkFilledFields() -> Bool {
        return self.delegatedFields.reduce(true, { (previousResult, inputField) -> Bool in
            return previousResult && inputField.hasText
        })
    }
}
