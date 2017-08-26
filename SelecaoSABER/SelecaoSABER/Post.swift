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
    
    
    // initializing object from json
    convenience init(from json: [String: Any]) { //throws {
        guard let id = json["id"] as? Int,
            let timestamp = json["timestamp"] as? Double,
            let author = json["author"] as? String,
            let avatar = json["avatar"] as? String,
            let title = json["title"] as? String,
            let message = json["message"] as? String else {
                //throw Constant.SerializationError.missing("id")
                fatalError("erro de serialização do Post")
        }
        
        self.init(id: id, timestamp: timestamp, author: author, avatar: avatar, title: title, message: message)
    }
}
