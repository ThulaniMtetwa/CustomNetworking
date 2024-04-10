//
//  PostService.swift
//  CustomNetworkingLayer
//
//  Created by Thulani Mtetwa on 2024/04/05.
//

import Foundation

protocol PostsRepository {
    func getPosts<T: Decodable>(responseEntity: T.Type) async -> Result<T, HTTPAPIError>
}

class PostsRepositoryImpl: PostsRepository, APIServiceable {
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    func getPosts<T: Decodable>(responseEntity: T.Type) async -> Result<T, HTTPAPIError> {
        let response =  await sendRequest(endpoint: JSONPlaceholderAPI.getPosts)
        
        switch response {
        case .success(let success):
            guard let decodedResponse = try? JSONDecoder().decode(responseEntity.self, from: success) else {
                return .failure(.decode)
            }
            return .success(decodedResponse)
        case .failure(let failure):
            return .failure(failure)
        }
    }
}
