//
//  OrderListView.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/06.
//

import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var store: Store  // 주문 정보를 다루려고 추가
    
    var body: some View {
        ZStack {
            if store.orders.isEmpty {
                emptyOrders  // 주문 내역이 없을 때 표시
            } else {
                orderList  // 주문 내역이 있을 때 표시
            }
        }
        .animation(.default)  // 뷰가 전환될 때 애니메이션 적용
        .navigationBarTitle("주문 목록")
        .navigationBarItems(trailing: editButton)  // 에디트 버튼 추가
    }
    
    var editButton: some View {
        !store.orders.isEmpty
            ? AnyView(EditButton())  // 주문 내역이 있을 때
            : AnyView(EmptyView())  // 주문 내역이 없을 때
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
    
    var orderList: some View {
        List {
            ForEach(store.orders) {
                OrderRow(order: $0)
            }
            .onDelete(perform: store.deleteOrder(at:))
        }
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
            .environmentObject(Store())
    }
}
