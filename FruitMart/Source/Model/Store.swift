//
//  Store.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/02.
//

import Foundation

// Store는 앱 전반에 걸쳐 사용하게 될 모델이므로 어디서든 쉽게 접근하고 활용할 수 있도록
// environmentObject 수식어로 추가해 줄 것인데
// 이 수식어는 ObservableObject 타입만 받기 때문에 프로토콜 채택
final class Store: ObservableObject {
    // 특정 상품의 데이터가 변경되면 그 변경 사실을 관련된 뷰들이 모두 알고 갱신할 수 있게 하기 위해
    @Published var products: [Product]
    
    init(filename: String = "ProductData.json") {
        self.products = Bundle.main.decode(filename: filename, as: [Product].self)
    }
}

extension Store {
    func toggleFavorite(of product: Product) {
        guard let index = products.firstIndex(of: product) else {
            return
        }
        
        products[index].isFavorite.toggle()
    }
}
