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
    // 전체 주문 목록
    @Published var orders: [Order] = [] {
        didSet { saveData(at: orderFilePath, data: orders) }
    }
    
    init(filename: String = "ProductData.json") {
        self.products = Bundle.main.decode(filename: filename, as: [Product].self)
    }
    
    func placeOrder(product: Product, quantity: Int) {
        let nextId = Order.orderSequence.next()!
        let order = Order(id: nextId, product: product, quantity: quantity)
        orders.append(order)
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

// MARK: - File Manager
extension Store {
    var orderFilePath: URL {
        let manager = FileManager.default
        
        // 라이브러리 디렉터리에 있는 Application Support 디렉터리 URL
        let appSupportDir = manager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        
        // 번들 ID를 서브 디렉토리로 추가
        let bundleID = Bundle.main.bundleIdentifier ?? "FruitMart"
        let appDir = appSupportDir.appendingPathComponent(bundleID, isDirectory: true)
        
        // 디렉터리가 없으면 생성
        if !manager.fileExists(atPath: appDir.path) {
            try? manager.createDirectory(at: appDir, withIntermediateDirectories: true)
        }
        
        // 지정한 경로에 파일명 추가 - Order.json
        return appDir.appendingPathComponent("Orders").appendingPathExtension("json")
    }
    
    func saveData<T>(at path: URL, data: T) where T: Encodable {
        do {
            let data = try JSONEncoder().encode(data)  // 부호화
            try data.write(to: path)  // 파일로 저장
        } catch {
            print(error)
        }
    }
}
