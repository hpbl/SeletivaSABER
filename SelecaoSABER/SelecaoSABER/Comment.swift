//
//  Comment.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import Foundation

class Comment: Content {
    var tid: Int
    
    init(id: Int, timestamp: Int, tid: Int, author: String, avatar: String, message: String) {
        self.tid = tid

        super.init(id: id, timestamp: timestamp, author: author, avatar: avatar, message: message)
    }
    
    // initializing object from json
    override init?(from json: [String: Any]) {
        
        if let tid = json["tid"] as? Int {
            self.tid = tid
        
        } else if let tidString = json["tid"] as? String,
            let tid = Int(tidString)  {
            self.tid = Int(tid)
        
        } else {
            return nil
        }
        
        super.init(from: json)
    }
}
