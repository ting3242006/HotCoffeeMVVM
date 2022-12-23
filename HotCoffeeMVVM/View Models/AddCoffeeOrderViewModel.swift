//
//  AddCoffeeOrderViewModel.swift
//  HotCoffeeMVVM
//
//  Created by Ting on 2022/11/23.
//

import Foundation

// 新增一份餐點的頁面
struct AddCoffeeOrderViewModel {
    
    var name: String?
    var email: String?
    
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] {
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
}
