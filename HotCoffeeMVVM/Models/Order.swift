//
//  Order.swift
//  HotCoffeeMVVM
//
//  Created by Ting on 2022/10/30.
//

import Foundation

// 加上 CaseIterable 讓 enum 變成 array 搭配使用
enum CoffeeType: String, Codable, CaseIterable {
    case capuccino
    case latte
    case espressino
    case cortado
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}

// helper function
extension Order {
    // creat another static property which return a particular resource in order
    static var all: Resource<[Order]> = {
        // define this property
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL is incorrect")
        }
        
        return Resource<[Order]>(url: url)
        
    }()
    
    static func creat(vm: AddCoffeeOrderViewModel) -> Resource<Order?> {
        
        let order = Order(vm)
        
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL is incorrect")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding order")
        }
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = HttpMethod.post
        resource.body = data
        
        return resource
    }
}

extension Order {
    
    // init that can pass in an instance of the view model
    init?(_ vm: AddCoffeeOrderViewModel) {
        // 從 vm 裡拿到 value
        // 用 gurad statement 是一個好方法去得到 property
        guard let name = vm.name,
              let email = vm.email,
              let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()),
              let selectedSize = CoffeeSize(rawValue: vm.selectedSize!.lowercased()) else {
            return nil
        }
        // assign these properties to the order properties
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
    }
}
