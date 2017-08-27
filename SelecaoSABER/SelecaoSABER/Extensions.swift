//
//  Extensions.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init?(from url: String) {
        
        guard let url = URL(string: url),
            let data =  try? Data(contentsOf: url)
        else {
            return nil
        }
        
        self.init(data: data)
    }
}

typealias NewPost = (title: String, message: String)
typealias NewComment = (message: String, post: Post)
