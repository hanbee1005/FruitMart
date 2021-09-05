//
//  Home.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/01.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject private var store: Store
    
    @State private var quickOrder: Product?  // 빠른 주문 기능으로 주문한 상품 저장
    
    var body: some View {
        NavigationView {
            List(store.products) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    ProductRow(product: product, quickOrder: self.$quickOrder)
                }
            }
            .navigationBarTitle("과일마트")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: Home()
                    .environmentObject(Store()))
    }
}
