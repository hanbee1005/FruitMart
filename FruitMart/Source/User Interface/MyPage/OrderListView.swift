//
//  OrderListView.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/06.
//

import SwiftUI

struct OrderListView: View {
    var body: some View {
        emptyOrders
            .navigationBarTitle("주문 목록")
    }
    
    var emptyOrders: some View {
        VStack(spacing: 25) {
            // 애셋에 포함된 박스 이미지
            Image("box")
                .renderingMode(.template)
                .foregroundColor(Color.gray.opacity(0.4))
            
            Text("주문 내역이 없습니다.")
                .font(.headline).fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}
