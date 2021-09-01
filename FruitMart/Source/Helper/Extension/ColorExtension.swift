//
//  ColorExtension.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/01.
//

import SwiftUI

extension Color {
    static let peach = Color("peach")  // 앱에 사용할 메인 색
    static let primaryShadow = Color.primary.opacity(0.2)  // 그림자에 사용할 색
    // Color.secondary 를 대신해 사용할 조금 더 진한 회색
    static let secondaryText = Color(hex: "#6e6e6e")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)  // 문자열 파서 역할을 하는 객체
        _ = scanner.scanString("#")  // scanScanner는 iOS 13부터 지원. # 문자 제거
        
        var rgb: UInt64 = 0
        // 문자열을 UInt64 타입으로 변환해 rgb 변수에 저장. 변환할 수 없다면 0을 반환
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}
