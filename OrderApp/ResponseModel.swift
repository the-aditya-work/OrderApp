//
//  ResponseModel.swift
//  OrderApp
//
//  Created by Aditya Rai on 11/06/25.
//

import Foundation

struct menuResponse: Codable {
    let items: [MenuItem]
}

struct categoriesResponse: Codable {
    let categories: [String]
}

struct OrderResponse: Codable {
    let prepTime: Int
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
