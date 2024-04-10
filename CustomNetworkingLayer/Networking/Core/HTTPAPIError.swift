//
//  HTTPAPIError.swift
//  CustomNetworkingLayer
//
//  Created by Thulani Mtetwa on 2024/04/05.
//

import Foundation

enum HTTPAPIError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorised
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            "Decoding Error"
        case .unauthorised:
            "Auth error"
        default:
            "Unknown Error"
        }
    }
}
