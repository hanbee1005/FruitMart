//
//  OrderRow.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/06.
//

import SwiftUI

struct OrderRow: View {
    let order: Order  // 주문 정보
    
    var body: some View {
        HStack {
            // 상품 이미지
            ResizedImage(order.product.imageName)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                // 상품명
                Text(order.product.name)
                    .font(.headline).fontWeight(.medium)
                
                // '주문 가격 | 주문 수량' 표시
                Text("₩\(order.price) | \(order.quantity)개")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .frame(height: 100)
    }
}

struct OrderRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderRow(order: Order(id: 1, product: productSamples[0], quantity: 3))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
