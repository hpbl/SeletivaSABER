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
    var accessToken: String = "4847f8cd66020a31d57c0a7d26f6a82e1fd992dd"
    
    var headers: HTTPHeaders {
        get {
            return ["Authorization": "Bearer \(self.accessToken)"]
        }
    }
    
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
                                posts.append(Post(from: postJSON))
                            }
                            callback(posts, nil)
                        }
                    }
                case .failure(let error):
                    callback(nil, error)
                }
        }
    }
    
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
                                comments.append(Comment(from: commentJSON))
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
