//
//  Extensions.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

extension UIImage {
    
    // como imagens vem do servidor no formato de uma URl,
    // precisamos de uma forma fácil de criar uma UIImage a partir da URL
    convenience init?(from url: String) {
        
        guard let url = URL(string: url),
            let data =  try? Data(contentsOf: url)
        else {
            return nil
        }
        
        self.init(data: data)
    }
}
