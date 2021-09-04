//
//  QuantitySelector.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/03.
//

import SwiftUI

struct QuantitySelector: View {
    @Binding var quantity: Int
    var range: ClosedRange<Int> = 1...20
    
    private let softFeedback = UIImpactFeedbackGenerator(style: .soft)
    private let rigidFeedback = UIImpactFeedbackGenerator(style: .rigid)
    
    var body: some View {
        HStack {
            // 수량 감소 버튼
            Button(action: { self.changeQuantity(-1) }) {
                Symbol("minus.circle.fill", scale: .large, color: Color.gray.opacity(0.5))
                    .padding()
            }
            
            // 현재 수량을 나타낼 텍스트
            Text("\(quantity)")
                .bold()
                .font(Font.system(.title, design: .monospaced))
                .frame(minWidth: 40, maxWidth: 60)
            
            // 수량 증가 버튼
            Button(action: { self.changeQuantity(1) }) {
                Symbol("plus.circle.fill", scale: .large, color: Color.gray.opacity(0.5))
                    .padding()
            }
        }
    }
    
    private func changeQuantity(_ num: Int) {
        if range ~= quantity + num {
            quantity += num
            softFeedback.prepare() // 진동 지연 시간을 줄일 수 있도록 미리 준비시키는 메소드
            softFeedback.impactOccurred(intensity: 0.8)
        } else {
            rigidFeedback.prepare()
            rigidFeedback.impactOccurred()
        }
    }
}

struct QuantitySelector_Previews: PreviewProvider {
    @State private var quantity = 0
    static var previews: some View {
        Group {
            QuantitySelector(quantity: .constant(1))
            QuantitySelector(quantity: .constant(10))
            QuantitySelector(quantity: .constant(20))
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
