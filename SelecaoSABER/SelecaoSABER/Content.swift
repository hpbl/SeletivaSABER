//
//  Content.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import Foundation

class Content {
    var id: Int
    var timestamp: Double
    var author: String
    var avatar: String
    var message: String
    
    init(id: Int, timestamp: Double, author: String, avatar: String, message: String) {
        self.id = id
        self.timestamp = timestamp
        self.author = author
        self.avatar = avatar
        self.message = message
    }
}
