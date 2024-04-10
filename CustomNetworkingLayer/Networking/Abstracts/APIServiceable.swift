//
//  APIServiceable.swift
//  CustomNetworkingLayer
//
//  Created by Thulani Mtetwa on 2024/04/05.
//

import Foundation


protocol APIServiceable {
    var urlSession: URLSession { get }
    func sendRequest(endpoint: URLRequestable) async -> Result<Data, HTTPAPIError>
}

extension APIServiceable {
    
    
    func sendRequest(endpoint: URLRequestable) async -> Result<Data, HTTPAPIError> {
        guard let request  = endpoint.request else {
            return .failure(.invalidURL)
        }
        
        do {
            let (data, response) = try await urlSession.data(for: request, delegate: nil)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                return .success(data)
            case 401:
                return .failure(.unauthorised)
            default:
                return .failure(.unexpectedStatusCode)
            }
            
        } catch {
            return .failure(.unknown)
        }
    }
}
    
