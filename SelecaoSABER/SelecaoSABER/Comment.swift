//
//  Comment.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import Foundation

// representação dos comentários na aplicação
class Comment: Content {
    var tid: Int
    
    init(id: Int, timestamp: Int, tid: Int, author: String, avatar: String, message: String) {
        self.tid = tid

        super.init(id: id, timestamp: timestamp, author: author, avatar: avatar, message: message)
    }
    
    override init?(from json: [String: Any]) {
        // Comentários já existentes no servidor
        // retornam um tid do tipo Int
        if let tid = json["tid"] as? Int {
            self.tid = tid
        
        // Comentários criados na aplicação quando
        // retornados pelo servidor apresrntam um tid
        // do tipo String
        } else if let tidString = json["tid"] as? String,
            let tid = Int(tidString)  {
            self.tid = Int(tid)
        
        } else {
            return nil
        }
        
        super.init(from: json)
    }
}

// o alias NewComment servirá para agrupar os dados
// que montam um novo Comment, antes de serem enviados ao servidor
typealias NewComment = (message: String, post: Post)
