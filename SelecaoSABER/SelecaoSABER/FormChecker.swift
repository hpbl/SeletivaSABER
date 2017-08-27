//
//  FormChecker.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 27/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

class FormChecker: NSObject, FormCheckerDelegate {
    
    var delegatedFields: [UIKeyInput] = []
    var delegatedButton: UIButton? = nil
    var delegatedBarButton: UIBarButtonItem? = nil

}

// precisamos chamar os métodos de conferência de preenchimento
// todas as vezes que houverem edições
extension FormChecker: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.delegatedButton?.isEnabled = self.checkFilledFields()
        self.delegatedBarButton?.isEnabled = self.checkFilledFields()
    }
}

// como o TextField não tem um DiDChange,
// é necessário fazer mais conferências nele
extension FormChecker: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        self.delegatedButton?.isEnabled = self.checkFilledFields()
        self.delegatedBarButton?.isEnabled = self.checkFilledFields()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.delegatedButton?.isEnabled = self.checkFilledFields()
        self.delegatedBarButton?.isEnabled = self.checkFilledFields()
        
        return true
    }
}
