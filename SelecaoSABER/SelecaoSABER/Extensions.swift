//
//  Extensions.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init(from url: String) {
        let data = try? Data(contentsOf: URL(string: url)!)
        
        self.init(data: data!)!
    }
}
