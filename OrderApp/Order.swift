//
//  Order.swift
//  OrderApp
//
//  Created by Aditya Rai on 11/06/25.
//

import Foundation

struct Order: Codable {
    var menuItems : [MenuItem]
    init(menuItems: [MenuItem] = []){
        self.menuItems = menuItems
    }
}
