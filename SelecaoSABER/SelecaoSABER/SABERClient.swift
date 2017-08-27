//
//  SABERClient.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import Foundation
import Alamofire

class SABERClient: DataProvider {
    
    // padrão de projeto Singleton
    // para que as requisições sejam feitas
    // pela mesma instância desta classe (mesmo token)
    static let shared = SABERClient()
    
    // init privado evitará inicialização
    // de outro objeto desta classe fora da mesma
    private init() {}
    
    var accessToken: String = ""
    var headers: HTTPHeaders {
        get {
            return ["Authorization": "Bearer \(self.accessToken)"]
        }
    }
    
    // O pod AlamoFire permite requisições flexíveis,
    // cuja resposta em JSON é tratada e enviada para o callback
    func getPosts(_ callback: @escaping ([Post]?, Error?) -> Void) {
        let requestURL = Constant.endPoint + Constant.URI.forum.rawValue
        
        Alamofire.request(requestURL,
                          method: .get,
                          headers: self.headers)
            .responseJSON  { response in
                switch (response.result) {
                    
                case .success(let value):
                    if let resultJSON = value as? [String: [Any]] {
                        
                        if let postsJSON = resultJSON["posts"] as? [[String: Any]] {
                            var posts: [Post] = []
                            for postJSON in postsJSON {
                                if let post = Post(from: postJSON) {
                                    posts.append(post)
                                }
                            }
                            callback(posts, nil)
                        }
                    }
                    
                case .failure(let error):
                    callback(nil, error)
                }
        }
    }
    
    // No Alamofire, o corpo da requisição (caso exista)
    // deve ser colocado como parameters da requisição
    func savePost(newPost: NewPost, callback: @escaping (Int?, Error?) -> Void) {
        let requestURL = Constant.endPoint + Constant.URI.createPost.rawValue
        
        let requestBody = ["title": newPost.title, "message": newPost.message]
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: requestBody,
                          headers: self.headers)
            .responseJSON { response in
                switch (response.result) {
                
                case .success(let value):
                    
                    /* No caso da criação de um novo post, o id nos
                     indica que foi feito salvamento com sucesso*/
                    if let resultJSON = value as? [String: Int] {
                        callback(resultJSON["id"], nil)
                        
                    }
                    
                case .failure(let error):
                    callback(nil, error)
                }
        }
    }
    
    func getComments(for post: Post, callback: @escaping ([Comment]?, Error?) -> Void) {
        let requestURL = Constant.endPoint + Constant.URI.forum.rawValue + String(post.id)
        
        Alamofire.request(requestURL,
                          method: .get,
                          headers: self.headers)
            .responseJSON { response in
                switch (response.result) {
                    
                case .success(let value):
                    if let resultJSON = value as? [String: Any] {
                        
                        if let commentsJSON = resultJSON["comments"] as? [[String: Any]] {
                            var comments: [Comment] = []
                            for commentJSON in commentsJSON {
                                if let comment = Comment(from: commentJSON) {
                                    comments.append(comment)
                                }
                            }
                            
                            callback(comments, nil)
                        }
                    }
                    
                case .failure(let error):
                    callback(nil, error)
                }
        }
        
    }
    
    func saveComment(newComment: NewComment, callback: @escaping (Any?, Any?, Error?) -> Void) {
        let requestURL = Constant.endPoint + Constant.URI.addComment.rawValue + String(newComment.post.id)
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: ["message": newComment.message],
                          headers: self.headers)
            .responseJSON { response in
                switch (response.result) {
                    
                case .success(let value):
                    if let resultJSON = value as? [String: Any] {
                        // novamente os ids indicam sucesso
                        callback(resultJSON["id"], resultJSON["tid"], nil)
                    }
                    
                case .failure(let error):
                    callback(nil, nil, error)
                }
        }
    }
    
    func generateToken(from key: String, callback: @escaping (String?, Error?) -> Void) {
        Alamofire.request(Constant.endPoint + Constant.URI.reset.rawValue + key,
                          method: .post)
            .responseJSON { response in
                
                switch (response.result) {
                case .success(let value):
                    if let json = value as? [String: Any] {
                        if let token = json["apiToken"] as? String {
                            // guardamos o novo token recebido
                            self.accessToken = token
                        }
                        callback(json["apiToken"] as? String, nil)
                    }
                case .failure(let error):
                    callback(nil, error)
                }
        }
    }
}
