//
//  RequestsCoordinatorProtocol.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import Foundation


protocol DataProvider {
    var accessToken: String { get set }
    
    func getPosts(_ callback: @escaping ([Post]?, Error?) -> Void)
    
    func savePost(title: String, message: String, callback: @escaping (Int?, Error?) -> Void)
    
    func getComments(for post: Post, callback: @escaping ([Comment]?, Error?) -> Void)
    
    func saveComment(message: String, on post: Post, callback: @escaping (Any?, Any?) -> Void)
    
    func generateToken(from key: String, callback: @escaping (String?, Error?) -> Void)
}
