//
//  Constants.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

struct Constant {
    static let endPoint = "https://mobile.sabertecnologias.com.br/api_seletiva"

    enum URI: String {
        case forum = "/forum/"
        case createPost = "/forum/create_post/"
        case addComment = "/forum/add_comment/"
        case reset = "/users/reset/"
    }
    
    // cores que serão reutilizadas na aplicação
    struct Color {
        static let textViewBorder = UIColor(red:204.0/255.0,
                                             green:204.0/255.0,
                                             blue:204.0/255.0,
                                             alpha:1.0)
    }
}
