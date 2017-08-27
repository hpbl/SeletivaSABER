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
    
    init(id: Int, timestamp: Int, author: String, avatar: String, title: String, message: String) {
        self.title = title
        
        super.init(id: id, timestamp: timestamp, author: author, avatar: avatar, message: message)
    }
    
    
    // initializing object from json
    override init?(from json: [String: Any]) {
        
        guard let title = json["title"] as? String else {
                return nil
        }
        
        self.title = title
        
        super.init(from: json)
    }
}
