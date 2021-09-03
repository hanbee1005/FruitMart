//
//  Order.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/03.
//

import Foundation

// 식별을 위한 Identifiable 프로토콜 채택
struct Order: Identifiable {
    static var orderSequence = sequence(first: 1) {  $0 + 1 }
    
    let id: Int
    let product: Product
    let quantity: Int
    
    var price: Int {
        product.price * quantity
    }
}
