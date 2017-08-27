//
//  Post.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import Foundation

// A classe Post descreve um Tópico na aplicação
class Post: Content {
    var title: String
    
    init(id: Int, timestamp: Int, author: String, avatar: String, title: String, message: String) {
        self.title = title
        
        super.init(id: id, timestamp: timestamp, author: author, avatar: avatar, message: message)
    }
    
    
    // incialização falível por JSON
    override init?(from json: [String: Any]) {
        
        guard let title = json["title"] as? String else {
                return nil
        }
        
        self.title = title
        
        super.init(from: json)
    }
}

// o alias NewPost servirá para agrupar os dados
// que montam um novo Post, antes de serem enviados ao servidor
typealias NewPost = (title: String, message: String)
