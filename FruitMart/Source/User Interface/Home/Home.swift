//
//  Home.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/01.
//

import SwiftUI

struct Home: View {
    let store: Store
    
    var body: some View {
        List(store.products, id: \.name) { product in
            ProductRow(product: product)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(store: Store())
    }
}
