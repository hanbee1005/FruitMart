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
}

extension Order: Codable {}
