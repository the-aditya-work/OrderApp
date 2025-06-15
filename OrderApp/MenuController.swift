//
//  MenuController.swift
//  OrderApp
//
//  Created by Aditya Rai on 11/06/25.
//

import Foundation
import UIKit

class MenuController {
    let baseURL = URL(string: "http://localhost:8080/")!
    
    static let shared = MenuController()
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdatedNotification, object: nil)
            userActivity.order = order
        }
    }
    
    func fetchCategories() async throws -> [String] {
        let categoriesURL = baseURL.appendingPathComponent("categories")
        let(data , response) = try await URLSession.shared.data(from:categoriesURL)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MenuControllerError.catgoriesNotFound
        }
        let decoder = JSONDecoder()
        let categoriesResponse = try decoder.decode(categoriesResponse.self, from: data)
        return categoriesResponse.categories
    }
    
    enum MenuControllerError: Error , LocalizedError {
        case catgoriesNotFound
        case menuItemsNotFound
        case orderRequestFailed
        case imageDataMissing
    }
    
    func fetchMenuItems(forCategory categoryName : String) async
    throws -> [MenuItem]{
        let initialMenuURL = baseURL.appendingPathComponent("menu" )
        var components = URLComponents(url: initialMenuURL,
        resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category",
        value: categoryName)]
         let menuURL = components.url!
        let(data, response) = try await URLSession.shared.data(from: menuURL)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MenuControllerError.menuItemsNotFound
        }
        let decoder = JSONDecoder()
        let menuItemsResponse = try decoder.decode(menuResponse.self, from: data)
        return menuItemsResponse.items
    }
    
    typealias MinutestoPrepare = Int
    func submitOrder(forMenuIDs menuIDs: [Int]) async throws ->
    MinutestoPrepare {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let menuIdsDict = ["menuIds": menuIDs]
        let jsonEncoder = JSONEncoder()
        
        let jsonData = try? jsonEncoder.encode(menuIdsDict)
        request.httpBody = jsonData
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MenuControllerError.orderRequestFailed
        }
        let decoder = JSONDecoder()
        let orderResponse = try decoder.decode(OrderResponse.self, from: data)
        return orderResponse.prepTime
        
        
    }
    static let orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")
    
        
    func fetchImage (from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data (from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MenuControllerError.imageDataMissing
        }
        guard let image = UIImage(data: data) else {
            throw MenuControllerError.imageDataMissing
        }
        return image
    }
    
    var userActivity = NSUserActivity(activityType: "com.example.OrderApp.order")
    
    func updateUserActivity(with controller: StateRestorationController) {
        switch controller {
        case .menu(let category) : userActivity.menuCategory = category
        case .menuItemDetail(let menuItem) : userActivity.menuItem = menuItem
        case .order, .categories:
            break
        }
        userActivity.controllerIdentifier = controller.identifier
    }
    
}
