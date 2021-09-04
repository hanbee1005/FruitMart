//
//  Symbol.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/04.
//

import SwiftUI

struct Symbol: View {
    let systemName: String
    let imageScale: Image.Scale
    let color: Color?
    
    init(
        _ systemName: String,
        scale imageScale: Image.Scale = .medium,
        color: Color? = nil) {
        self.systemName = systemName
        self.imageScale = imageScale
        self.color = color
    }
    
    var body: some View {
        Image(systemName: systemName)
            .imageScale(imageScale)
            .foregroundColor(color)
    }
}

struct Symbol_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Symbol("heart.fill")
            Symbol("heart.fill", scale: .large)
            Symbol("heart.fill", color: .peach)
            Symbol("heart.fill", scale: .large, color: .peach)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
