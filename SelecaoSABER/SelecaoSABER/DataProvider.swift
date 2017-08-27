//
//  RequestsCoordinatorProtocol.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import Foundation

// abstração da camda de requisição/persistência dos dados
protocol DataProvider {
    var accessToken: String { get set }
    
    func getPosts(_ callback: @escaping ([Post]?, Error?) -> Void)
    
    func savePost(newPost: NewPost, callback: @escaping (Int?, Error?) -> Void)
    
    func getComments(for post: Post, callback: @escaping ([Comment]?, Error?) -> Void)
    
    func saveComment(newComment: NewComment, callback: @escaping (Any?, Any?, Error?) -> Void)
    
    func generateToken(from key: String, callback: @escaping (String?, Error?) -> Void)
}
