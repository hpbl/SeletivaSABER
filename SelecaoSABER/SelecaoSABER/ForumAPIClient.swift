//
//  RequestsCoordinatorProtocol.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import Foundation


protocol ForumAPIClient {
    var accessToken: String { get set }
    
    func getPosts(_ callback: @escaping ([Post]) -> Void)
    
    func save(title: String, message: String, callback: @escaping (Int?) -> Void)
    
    func getComments(for post: Post, callback: @escaping ([Comment]) -> Void)
}
