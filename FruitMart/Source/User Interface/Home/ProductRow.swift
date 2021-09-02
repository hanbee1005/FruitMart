//
//  ProductRow.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/01.
//

import SwiftUI

struct ProductRow: View {
    var body: some View {
        HStack {
            productImage        // 상품 이미지
            productDescription  // 상품 설명
        }
        .frame(height: 150)  // 뷰 전체의 높이를 150으로 설정
        .background(Color.primary.colorInvert())
        .cornerRadius(6)
        .shadow(color: .primaryShadow,radius: 1, x: 2, y: 2)
        .padding(.vertical, 8)
    }
}

private extension ProductRow {
    var productImage: some View {
        Image("apple")
            .resizable()
            .scaledToFill()
            .frame(width: 140)
            .clipped()
    }
    
    var productDescription: some View {
        VStack (alignment: .leading) {
            // 상품명
            Text("백설공주 사과")
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 6)
            
            // 상품 설명
            Text("달콤한 맛이 좋은 과일의 여왕 사과. 독은 없고 꿀만 가득해요!")
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
                + Text("2100").font(.headline)
            
            Spacer()
            
            // 하트 아이콘
            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundColor(.peach)
                .frame(width: 32, height: 32)
            
            // 카트 아이콘
            Image(systemName: "cart")
                .foregroundColor(.peach)
                .frame(width: 32, height: 32)
        }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow()
    }
}