//
//  PostAPITest.swift
//  CustomNetworkingLayerTests
//
//  Created by Thulani Mtetwa on 2024/04/10.
//

import Foundation
import XCTest

@testable import CustomNetworkingLayer

class PostAPITest: XCTestCase {
  var postDetailAPI: PostsRepositoryImpl!
  var expectation: XCTestExpectation!
  let apiURL = URL(string: "https://jsonplaceholder.typicode.com/posts")!
  
  override func setUp() {
    let configuration = URLSessionConfiguration.default
    configuration.protocolClasses = [MockURLProtocol.self]
    let urlSession = URLSession.init(configuration: configuration)
    
    postDetailAPI = PostsRepositoryImpl(urlSession: urlSession)
    expectation = expectation(description: "Expectation")
  }
    
    
    func testSuccessfulResponse() {
      
    }
}
