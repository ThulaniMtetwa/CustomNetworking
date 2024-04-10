//
//  Encodable+Encode.swift
//  CustomNetworkingLayer
//
//  Created by Thulani Mtetwa on 2024/04/05.
//

import Foundation

extension Encodable {
    func encode() -> Data? {
        do {
           return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
