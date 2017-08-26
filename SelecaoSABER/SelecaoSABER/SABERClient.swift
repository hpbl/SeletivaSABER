//
//  SABERClient.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import Foundation
import Alamofire

class SABERClient: ForumAPIClient {
    var accessToken: String = "4847f8cd66020a31d57c0a7d26f6a82e1fd992dd"
    
    var headers: HTTPHeaders {
        get {
            return ["Authorization": "Bearer \(self.accessToken)"]
        }
    }
    
    func getPosts(_ callback: @escaping ([Post]) -> Void) {
        let requestURL = Constant.endPoint + Constant.URI.forum.rawValue
        
        Alamofire.request(requestURL,
                          method: .get,
                          headers: self.headers)
            .responseJSON  { response in
                if let resultJSON = response.result.value as? [String: [Any]] {
                    
                    if let postsJSON = resultJSON["posts"] as? [[String: Any]] {
                        var posts: [Post] = []
                        for postJSON in postsJSON {
                            posts.append(Post(from: postJSON))
                        }
                        
                        callback(posts)
                    }
                } else {
                    fatalError("no response")
                }
        }
    }
    
    func save(title: String, message: String, callback: @escaping (Int?) -> Void) {
        let requestURL = Constant.endPoint + Constant.URI.createPost.rawValue
        
        let requestBody = ["title": title, "message": message]
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: requestBody,
                          headers: self.headers)
            .responseJSON { response in
                if let resultJSON = response.result.value as? [String: Int] {
                        callback(resultJSON["id"])
                    
                }
        }
    }
    
    func getComments(for post: Post, callback: @escaping ([Comment]) -> Void) {
        let requestURL = Constant.endPoint + Constant.URI.forum.rawValue + "/" + String(post.id)
        
        Alamofire.request(requestURL,
                          method: .get,
                          headers: self.headers)
            .responseJSON { response in
                if let resultJSON = response.result.value as? [String: Any] {
                    
                    if let commentsJSON = resultJSON["comments"] as? [[String: Any]] {
                        var comments: [Comment] = []
                        for commentJSON in commentsJSON {
                            comments.append(Comment(from: commentJSON))
                        }
                        
                        callback(comments)
                    }
                } else {
                    fatalError("no response")
                }
        }
        
    }
}
