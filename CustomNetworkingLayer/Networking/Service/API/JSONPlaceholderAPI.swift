//
//  JSONPlaceholderAPI.swift
//  CustomNetworkingLayer
//
//  Created by Thulani Mtetwa on 2024/04/05.
//

import Foundation

enum JSONPlaceholderAPI: URLRequestable {
    
    var requestBody: (any Encodable)? {
        switch self {
        case .createPost(let request):
            return request
            
        default: return nil
        }
    }
    
    case getPosts
    case createPost(request: Post)
    
    var path: String {
        switch self {
        case .getPosts, .createPost:
            "/posts"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getPosts:
                .GET
        case .createPost:
                .POST
        }
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}
