//
//  ProductRow.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/01.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    
    @EnvironmentObject var store: Store
    @Binding var quickOrder: Product?
    
    @State private var willAppear: Bool = false
    
    var body: some View {
        HStack {
            productImage        // 상품 이미지
            productDescription  // 상품 설명
        }
        .frame(height: store.appSetting.productRowHeight)  // 뷰 전체의 높이를 150으로 설정
        .background(Color.primary.colorInvert())
        .cornerRadius(6)
        .shadow(color: .primaryShadow,radius: 1, x: 2, y: 2)
        .padding(.vertical, 8)
        .opacity(willAppear ? 1 : 0)
        .animation(.easeInOut(duration: 0.4))
        .onAppear { self.willAppear = true }
        .contextMenu { contextMenu }
    }
    
    var contextMenu: some View {
        VStack {
            // 즐겨찾기 여부 변경
            Button(action: { self.toggleFavorite() }) {
                Text("Toggle Favorite")
                Symbol(self.product.isFavorite ? "heart.fill" : "heart")
            }
            // 빠른 주문 기능
            Button(action: { self.orderProduct() }) {
                Text("Order Product")
                Symbol("cart")
            }
        }
    }
    
    func toggleFavorite() {
        store.toggleFavorite(of: product)
    }
}

private extension ProductRow {
    var productImage: some View {
        ResizedImage(product.imageName)
            .frame(width: 140)
            .clipped()
    }
    
    var productDescription: some View {
        VStack (alignment: .leading) {
            // 상품명
            Text(product.name)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 6)
            
            // 상품 설명
            Text(product.description)
                .font(.footnote)
                .foregroundColor(.secondaryText)
            
            Spacer()
            
            footerView
        }
        .padding([.leading, .bottom], 12)
        .padding([.top, .trailing])
    }
    
    var footerView: some View {
        HStack (spacing: 0) {
            // 가격 정보
            Text("₩").font(.footnote)
                + Text("\(product.price)").font(.headline)
            
            Spacer()
            
            FavoriteButton(product: product)
            
            // 카트 아이콘
            Image(systemName: "cart")
                .foregroundColor(.peach)
                .frame(width: 32, height: 32)
                .onTapGesture {
                    self.orderProduct()
                }
        }
    }
    
    func orderProduct() {
        quickOrder = product  // 주문 상품 저장. 팝업창 출력 조건
        store.placeOrder(product: product, quantity: 1)  // 상품 1개 주문
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(productSamples) {
                ProductRow(product: $0, quickOrder: .constant(nil))
            }
            
            ProductRow(product: productSamples[0], quickOrder: .constant(nil))
                .preferredColorScheme(.dark)  // 다크 모드 설정
        }
        .padding()  // sizeThatFits를 이용하여 보더라도 약간의 여백을 주도록 추가
        .previewLayout(.sizeThatFits) // 콘텐츠 크기에 맞춰서 프리뷰 컨테이너 크기 조정
        .environmentObject(Store())
    }
}
