//
//  Content.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

class Content {
    var id: Int
    var timestamp: Int
    var author: String
    var avatar: String
    var message: String
    var avatarImage: UIImage
    
    init(id: Int, timestamp: Int, author: String, avatar: String, message: String) {
        
        self.id = id
        self.timestamp = timestamp
        self.author = author
        self.avatar = avatar
        self.message = message
        
        if let avatarImage = UIImage(from: self.avatar) {
            self.avatarImage = avatarImage
        } else {
            self.avatarImage = #imageLiteral(resourceName: "noAvatar")
        }
    }
    
    // initializing object from json
    init(from json: [String: Any]) { //throws {
        guard let id = json["id"] as? Int,
            let timestamp = json["timestamp"] as? Int,
            let author = json["author"] as? String,
            let avatar = json["avatar"] as? String,
            let message = json["message"] as? String else {
                //throw Constant.SerializationError.missing("id")
                //TODO: TRATAR ERRO DE serialização
                fatalError("erro de serialização do Post")
        }
        
        self.id = id
        self.timestamp = timestamp
        self.author = author
        self.avatar = avatar
        self.message = message
        
        if let avatarImage = UIImage(from: self.avatar) {
            self.avatarImage = avatarImage
        } else {
            self.avatarImage = #imageLiteral(resourceName: "noAvatar")
        }
    }
}
