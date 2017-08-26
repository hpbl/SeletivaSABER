//
//  Constants.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import Foundation

struct Constant {
    static let endPoint = "https://mobile.sabertecnologias.com.br/api_seletiva"

    enum URI: String {
        case forum = "/forum"
        case createPost = "/forum/create_post"
        case addComment = "/forum/add_comment"
    }
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
}
