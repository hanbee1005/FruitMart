//
//  OrderComplateMessage.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/05.
//

import SwiftUI

struct OrderComplateMessage: View {
    var body: some View {
        Text("주문 완료")
            .font(.system(size: 24))
            .bold()  // 볼드체
            .kerning(2)  // 자간 조정
    }
}

struct OrderComplateMessage_Previews: PreviewProvider {
    static var previews: some View {
        OrderComplateMessage()
    }
}
