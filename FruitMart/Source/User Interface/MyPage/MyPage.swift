//
//  MyPage.swift
//  FruitMart
//
//  Created by 손한비 on 2021/09/06.
//

import SwiftUI

struct MyPage: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationView {
            // 폼을 이용해 마이 페이지 메뉴 그룹화
            Form {
                orderInfoSection
                appSettingSection  // 앱 설정 색션
            }
            .navigationBarTitle("마이페이지")
        }
    }
    
    var orderInfoSection: some View {
        // 색션을 사용해 이후에 추가될 다른 메뉴와 구분
        Section(header: Text("주문 정보").fontWeight(.medium)) {
            NavigationLink(destination: OrderListView()) {
                Text("주문 목록")
            }
            .frame(height: 44)  // 높이 지정
        }
    }
    
    var appSettingSection: some View {
        Section(header: Text("앱 설정").fontWeight(.medium)) {
            Toggle("즐겨찾는 상품 표시", isOn: $store.appSetting.showFavoriteList)
                .frame(height: 44)
        }
    }
}

struct MyPage_Previews: PreviewProvider {
    static var previews: some View {
        MyPage()
            .environmentObject(Store())
    }
}
