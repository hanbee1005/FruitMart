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
    @State private var showingFavoriteImage: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                // 즐겨찾기 상품이 없으면 무시
                if showFavorite {
                    favoriteProducts  // 구현해 둔 스크롤 뷰에 해당하는 프로퍼티
                }
                darkerDivider
                productList  // 기존에 있던 코드를 프로퍼티로 추출
            }
        }
        .popupOverContext(item: $quickOrder, style: .blur, content: popupMessage(product:))
    }
    
    var favoriteProducts: some View {
        FavoriteProductScrollView(showingImage: $showingFavoriteImage)
            .padding(.top, 24)
            .padding(.bottom, 8)
    }
    
    var darkerDivider: some View {
        Color.primary
            .opacity(0.3)
            .frame(maxWidth: .infinity, maxHeight: 1)
    }
    
    var productList: some View {
        List(store.products) { product in
            NavigationLink(destination: ProductDetailView(product: product)) {
                ProductRow(product: product, quickOrder: self.$quickOrder)
            }
        }
        .navigationBarTitle("과일마트")
    }
    
    var showFavorite: Bool {
        !store.products.filter({ $0.isFavorite }).isEmpty
    }
    
    func popupMessage(product: Product) -> some View {
        let name = product.name.split(separator: " ").last!
        return VStack {
            Text(name)  // 상품명 표시
                .font(.title).bold().kerning(3)
                .foregroundColor(.peach)
                .padding()
            
            OrderComplateMessage()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: Home()
                    .environmentObject(Store()))
    }
}
