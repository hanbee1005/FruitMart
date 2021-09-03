//
//  ProductDetailView.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/02.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product  // 상품 정보를 전달받기 위한 프로퍼티 선언
    
    var body: some View {
        VStack(spacing: 0) {
            productImage // 상품 이미지
            orderView  // 상품 정보를 출력하고 그 상품을 주문하기 위한 뷰
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    var productImage: some View {
        GeometryReader { _ in
            Image(self.product.imageName)
                .resizable()
                .scaledToFill()
        }
    }
    
    // 상품 설명과 주문하기 버튼 등을 모두 포함하는 컨테이너
    var orderView: some View {
        GeometryReader {
            VStack(alignment: .leading) {
                self.productDescription  // 상품명과 즐겨찾기 버튼 (하트 모양) 이미지
                Spacer()
                self.priceInfo  // 가격 정보
                self.placeOrderButton // 주문하기 버튼
            }
            // 지오메트리 리더가 차지하는 뷰의 높이보다 VStack 높이가 10정도 크도록
            .frame(height: $0.size.height + 10)
            .padding(32)
            .background(Color.white)  // 다크모드에서도 흰색 배경을 사용하기 위해
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
        }
    }
    
    var productDescription: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(product.name)  // 상품명
                    .font(.largeTitle).fontWeight(.medium)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "heart")  // 즐겨찾기 버튼
                    .imageScale(.large)
                    .foregroundColor(.peach)
                    .frame(width: 32, height: 32)
            }
            
            Text(splitText(product.description))  // 상품 설명
                .foregroundColor(.secondaryText)
                .fixedSize()
        }
    }
    
    var priceInfo: some View {
        HStack {
            (Text("₩")  // 통화 기호는 작게 나타내고 가격만 더 크게 표시
                + Text("\(product.price)").font(.title)
            ).fontWeight(.medium)
            
            Spacer()
            
            // 수량 선택 버튼이 들어갈 위치
        }
        // 배경을 다크모드에서도 항상 흰색이 되게 지정해 텍스트도 항상 검은색이 되게 지정
        .foregroundColor(.black)
    }
    
    // 주문하기 버튼
    var placeOrderButton: some View {
        Button(action: { }) {
            Capsule()
                .fill(Color.peach)
                // 너비는 주어진 공간을 최대한 사용하고 높이는 최소, 최대치 지정
                .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 55)
                .overlay(Text("주문하기")
                            .font(.system(size: 20)).fontWeight(.medium)
                            .foregroundColor(.white))
                .padding(.vertical, 8)
        }
    }
    
    func splitText(_ text: String) -> String {
        guard !text.isEmpty else { return text}
        let centerIdx = text.index(text.startIndex, offsetBy: text.count / 2)
        let centerSpaceIdx = text[..<centerIdx].lastIndex(of: " ") ?? text[centerIdx...].firstIndex(of: " ") ?? text.index(before: text.endIndex)
        let afterSpaceIdx = text.index(after: centerSpaceIdx)
        let lhsString = text[..<afterSpaceIdx].trimmingCharacters(in: .whitespaces)
        let rhsString = text[afterSpaceIdx...].trimmingCharacters(in: .whitespaces)
        return String(lhsString + "\n" + rhsString)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: productSamples[0])
    }
}
