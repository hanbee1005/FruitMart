//
//  Home.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/01.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            ProductRow()
            ProductRow()
            ProductRow()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct ProductRow: View {
    var body: some View {
        HStack {
            // 상품 이미지
            Image("apple")
                .resizable()
                .scaledToFill()
                .frame(width: 140)
                .clipped()
            
            VStack (alignment: .leading) {
                // 상품명
                Text("백설공주 사과")
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding(.bottom, 6)
                
                // 상품 설명
                Text("달콤한 맛이 좋은 과일의 여왕 사과. 독은 없고 꿀만 가득해요!")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                HStack (spacing: 0) {
                    // 가격 정보
                    Text("₩").font(.footnote)
                        + Text("2100").font(.headline)
                    
                    Spacer()
                    
                    // 하트 아이콘
                    Image(systemName: "heart")
                        .imageScale(.large)
                        .foregroundColor(Color("peach"))
                        .frame(width: 32, height: 32)
                    
                    // 카트 아이콘
                    Image(systemName: "cart")
                        .foregroundColor(Color("peach"))
                        .frame(width: 32, height: 32)
                }
            }
            .padding([.leading, .bottom], 12)
            .padding([.top, .trailing])
        }
        .frame(height: 150)  // 뷰 전체의 높이를 150으로 설정
        .background(Color.primary.colorInvert())
        .cornerRadius(6)
        .shadow(color: Color.primary.opacity(0.33),radius: 1, x: 2, y: 2)
        .padding(.vertical, 8)
    }
}
