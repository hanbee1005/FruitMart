//
//  Store.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/02.
//

import Foundation

final class Store {
    var products: [Product]
    
    init(filename: String = "ProductData.json") {
        self.products = Bundle.main.decode(filename: filename, as: [Product].self)
    }
}
