//
//  ViewController.swift
//  CustomNetworkingLayer
//
//  Created by Thulani Mtetwa on 2024/04/05.
//

import UIKit
import Combine

class ViewModel {
    private let serviceAPI:PostService = PostServiceImplementation()
    
    func loadData() {
        Task(priority: .background) {
            let repo = PostsRepositoryImpl()
            let result = await repo.getPosts(responseEntity: Posts.self)
            
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let v = ViewModel()
        v.loadData()

    }


}

