//
//  ShrinkButtonStyle.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/04.
//

import SwiftUI

// ButtonStyle 프로토콜 채택
struct ShrinkButtonStyle: ButtonStyle {
    // 버튼이 눌리고 있을 때 변화할 크기와 투명도 지정
    let minScale: CGFloat = 0.9
    let minOpacity: Double = 0.6
    
    func makeBody(configuration: Configuration) -> some View {
        // 기본 버튼 UI
        configuration.label
            .scaleEffect(configuration.isPressed ? minScale : 1)
            .opacity(configuration.isPressed ? minOpacity : 1)
    }
}
