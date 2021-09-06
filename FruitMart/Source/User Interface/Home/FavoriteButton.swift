//
//  FavoriteButton.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/03.
//

import SwiftUI

struct FavoriteButton: View {
    @EnvironmentObject private var store: Store
    let product: Product
    
    private var imageName: String {
        product.isFavorite ? "heart.fill" : "heart"  // 즐겨찾기 여부에 따라 심볼 변경
    }
    
    var body: some View {
        Symbol(imageName, scale: .large, color: .peach)
            .frame(width: 32, height: 32)
            .onTapGesture {
                withAnimation {
                    self.store.toggleFavorite(of: product)
                }
            }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FavoriteButton(product: productSamples[0])
            FavoriteButton(product: productSamples[2])
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
