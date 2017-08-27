//
//  Content.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

// superclasse Content abstrai o que existe de comum
// entre um Tópico e um Comentário
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
    
    // a inicialização também pode ser feita através de um JSON,
    // porém existe o risco de ser falha
    init?(from json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let timestamp = json["timestamp"] as? Int,
            let author = json["author"] as? String,
            let avatar = json["avatar"] as? String,
            let message = json["message"] as? String else {
                return nil
        }
        
        self.id = id
        self.timestamp = timestamp
        self.author = author
        self.avatar = avatar
        self.message = message
        
        // Como as imagens são armazenadas na internet,
        // é necessário uma alternativa caso não possam ser acessadas
        if let avatarImage = UIImage(from: self.avatar) {
            self.avatarImage = avatarImage
        } else {
            self.avatarImage = #imageLiteral(resourceName: "noAvatar")
        }
    }
}
