//
//  PopUpDelegate.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 27/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import PopupDialog
import UIKit

class PopUpDelegate {
    
    class func showNoNetworkPopup(on viewController: UIViewController,
                                  with tryAgainAction: @escaping () -> ()) {
        let title = "Algo não está certo"
        let message = "Verifique sua conexão com a internet e tente novamente"
        
        let popup = PopupDialog(title: title, message: message)
        
        // Create buttons
        let cancelButton = CancelButton(title: "cancelar") {
            popup.dismiss(animated: true, completion: nil)
        }
        
        let tryAgainButton = DefaultButton(title: "tentar novamente") {
            tryAgainAction()
        }
        
        popup.addButtons([cancelButton, tryAgainButton])
        
        popup.buttonAlignment = .horizontal

        viewController.present(popup, animated: true, completion: nil)
    }
}
