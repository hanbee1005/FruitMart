//
//  Popup.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/05.
//

import SwiftUI

enum PopupStyle {
    case none
    case blur
    case dimmed
}

// ViewModifier 프로토콜 채택
struct Popup<Message: View>: ViewModifier {
    let size: CGSize?  // 팝업창의 크기
    let style: PopupStyle  // 앞에서 정의한 팝업 스타일
    let message: Message  // 팝업창에 나타낼 메시지
    
    init(
        size: CGSize? = nil,
        style: PopupStyle = .none,
        message: Message
    ) {
        self.size = size
        self.style = style
        self.message = message
    }
    
    func body(content: Content) -> some View {
        content  // 팝업창을 띄우는 뷰
            .blur(radius: style == .blur ? 2 : 0)  // blur 스타일인 경우에만 적용
            .overlay(Rectangle()  // dimmed 스타일인 경우에만 적용
                        .fill(Color.black.opacity(style == .dimmed ? 0.4 : 0)))
            .overlay(popupContent)  // 팝업창으로 표현될 뷰
    }
    
    private var popupContent: some View {
        GeometryReader {
            // 팝업창에서 표시할 메시지
            VStack {
                self.message
            }
            .frame(
                width: self.size?.width ?? $0.size.width * 0.6,
                height: self.size?.height ?? $0.size.height * 0.25
            )
            .background(Color.primary.colorInvert())
            .cornerRadius(12)
            .shadow(color: .primaryShadow, radius: 15, x: 5, y: 5)
            .overlay(self.checkCircleMark, alignment: .top)
        }
    }
    
    // 팝업창 상단에 위치한 체크 마크 심볼
    private var checkCircleMark: some View {
        Symbol("checkmark.circle.fill", color: .peach)
            .font(Font.system(size: 60).weight(.semibold))
            .background(Color.white.scaleEffect(0.8))  // 체크 마크 배경 색을 흰색으로 지정
            .offset(x: 0, y: -20)  // 팝업창 상단에 걸쳐지도록 원래 위치보다 위로 가도록 조정
    }
}

// ViewModifier 프로토콜 채택
fileprivate struct PopupToggle: ViewModifier {
    @Binding var isPresented: Bool  // true 일 때만 팝업창 표시
    
    func body(content: Content) -> some View {
        content
            .disabled(isPresented)
            .onTapGesture {
                self.isPresented.toggle()  // 팝업창 종료
            }
    }
}
