//
//  Post.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import Foundation

class Post: Content {
    var title: String
    
    init(id: Int, timestamp: Double, author: String, avatar: String, title: String, message: String) {
        self.title = title

        super.init(id: id, timestamp: timestamp, author: author, avatar: avatar, message: message)
    }
}
