//
//  ProductDetailView.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/02.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product  // 상품 정보를 전달받기 위한 프로퍼티 선언
    
    @State private var quantity: Int = 1
    @State private var showingAlert: Bool = false
    @State private var showingPopup: Bool = false
    
    @EnvironmentObject private var store: Store
    
    var body: some View {
        VStack(spacing: 0) {
            productImage // 상품 이미지
            orderView  // 상품 정보를 출력하고 그 상품을 주문하기 위한 뷰
        }
        .popup(isPresented: $showingPopup, content: {
            Text("팝업")
        })
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showingAlert) { confirmAlert }  // alert 수식어 추가
    }
    
    var productImage: some View {
        GeometryReader { _ in
            ResizedImage(self.product.imageName)
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
            .padding(32)
            // 지오메트리 리더가 차지하는 뷰의 높이보다 VStack 높이가 10정도 크도록
            .frame(height: $0.size.height + 10)
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
                
                FavoriteButton(product: product)
            }
            
            Text(splitText(product.description))  // 상품 설명
                .foregroundColor(.secondaryText)
                .fixedSize()
        }
    }
    
    var priceInfo: some View {
        let price = quantity * product.price  // 수량 * 상품 가격
        return HStack {
            (Text("₩")  // 통화 기호는 작게 나타내고 가격만 더 크게 표시
                + Text("\(price)").font(.title)
            ).fontWeight(.medium)
            
            Spacer()
            
            // 수량 선택 버튼
            QuantitySelector(quantity: $quantity)
        }
        // 배경을 다크모드에서도 항상 흰색이 되게 지정해 텍스트도 항상 검은색이 되게 지정
        .foregroundColor(.black)
    }
    
    // 주문하기 버튼
    var placeOrderButton: some View {
        Button(action: {
                self.showingAlert = true  // 주문하기 버튼 클릭 시 알림창 출력
        }) {
            Capsule()
                .fill(Color.peach)
                // 너비는 주어진 공간을 최대한 사용하고 높이는 최소, 최대치 지정
                .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 55)
                .overlay(Text("주문하기")
                            .font(.system(size: 20)).fontWeight(.medium)
                            .foregroundColor(.white))
                .padding(.vertical, 8)
        }
        .buttonStyle(ShrinkButtonStyle())  // 커스텀 버튼 스타일 적용
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
    
    // 알림창에 표시할 내용 정의
    var confirmAlert: Alert {
        Alert(
            title: Text("주문 확인"),
            message: Text("\(product.name)을(를) \(quantity)개 구매하겠습니까?"),
            primaryButton: .default(Text("확인"), action: {
                self.placeOrder()  // 확인 버튼을 눌렀을 때 동작하도록 구현
            }),
            secondaryButton: .cancel(Text("취소"))
        )
    }
    
    // 상품과 수량 정보를 placeOrder 메소드에 인수로 전달
    func placeOrder() {
        store.placeOrder(product: product, quantity: quantity)
        showingPopup = true
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let source1 = ProductDetailView(product: productSamples[0])
        let source2 = ProductDetailView(product: productSamples[2])
        return Group {
            // 나머지 매개 변수 생략 시 총 4가지 환경에서의 프리뷰 출력
            Preview(source: source1)
            // iPhone 11 Pro + 라이트 모드 - 1가지 환경에서만 출력
            Preview(source: source2, devices: [.iPhone11Pro], displayDarkMode: false)
        }
    }
}
