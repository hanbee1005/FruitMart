# FruitMart
스윗한SwiftUI 과일마트 프로젝트 따라하기

## 프로젝트 구조
```
FruitMart
├─Source
│  ├─Application
│  │  ├─AppDelegate.swift
│  │  └─SceneDelegate.swift
│  │      
│  ├─User Interface
│  │  ├─MainTabView.swift  // TabView
│  │  ├─Home
│  │  ├─Recipe
│  │  ├─ImageGallery
│  │  └─MyPage
│  │      
│  ├─Helper
│  │  ├─CustomStyle
│  │  ├─CustomView
│  │  ├─Extension
│  │  └─ViewModifier
│  │      
│  └─Model  // 데이터 관련 모델 객체
│          
├─Resources
│  ├─Assets.xcassets    // 이미지와 색 설정
│  └─ProductData.json   // 더미 데이터 (read-only)
│  
├─Supporting Files
│  ├─LaunchScreen.stiryboard
│  └─Info.plist
│  
└─Preview Content
   └─Preview Assets.xcassets

```

- xcode로 프로젝트 실행 후 FruitMart > Build Settings > Packaging 에서 Info.plist File 을 FruitMart/Supporting Files/Info.plist 로 정확하게 입력!

- ContentView.swift 파일을 Home.swift 파일로 변경하였기 때문에 기존 ContentView() 를 사용한 부분을 Home() 으로 변경!       
  (Home.swift, SceneDelegate.swift 파일 수정)


## 이슈
1. popup 뷰 가운데 정렬 안됨
이슈: 상품을 주문한 경우, 주문 완료 알림을 popup 뷰로 띄우는데 왼쪽 상단에 고정되서 나오는 문제가 있었음.      
해결: GeometryReader 내부 VStack에 position 수식어를 추가하여 중앙에 위치하도록 수정 (책에 코드 빠짐...)
```swift
// Popup.swift
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
        .position(x: $0.size.width / 2, y: $0.size.height / 2)  // 이 부분 추가!!
    }
}
```

2. 테이블 row separator 안 사라짐
이슈: list 내 row를 구분하는 선이 아래와 같은 코드를 추가하였지만 사라지지 않음. 
```swift
List {
    ...
}
.onAppear {
    UITableView.appearance().separatorStyle = .none
}
```
해결: 

3. 상단 status bar 제거 안됨
이슈: 레시피 탭에서만 상태표시줄이 보이지 않도록 아래 코드를 추가하였지만 사라지지 않음
```swift
TabView(selection: $selectedTab) {
    Group {
        home
        recipe
        gallery
        myPage
    }
    .accentColor(Color.primary)
}
.accentColor(.peach)
.edgesIgnoringSafeArea(.top)
// selectedTab의 값이 recipe인 경우에만 상태 표시줄 숨김 처리
.statusBar(hidden: selectedTab == .recipe)
```
해결: 각 탭을 이루는 뷰마다 statusBar(hidden:) 수식어를 적용할 수 있도록 위치 수정
```swift
TabView(selection: $selectedTab) {
    Group {
        home
        recipe
        gallery
        myPage
    }
    .accentColor(Color.primary)
    // selectedTab의 값이 recipe인 경우에만 상태 표시줄 숨김 처리
    .statusBar(hidden: selectedTab == .recipe)
}
.accentColor(.peach)
.edgesIgnoringSafeArea(.top)
```