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

## 주요 기능

### NavigationView
내비게이션 스택을 이용해 콘텐츠 뷰들을 관리하는 컨테이너 뷰

- 기본 형태
```swift
NavigationView {
  // 나타내고자 하는 뷰
  Image("SwiftUI")
}
```

- 내비게이션 바 타이틀(NavigationBarTitle) : 나타내고자 하는 뷰의 수식어로 추가
```swift
NavigationView {
  ...
    .navigationBarTitle("네비게이션 바 타이틀", displayMode: .large) // displayMode: .large, .inline
}
```

- 내비게이션 바 아이템(NavigationBarItems) : 나타내고자 하는 뷰의 수식어로 추가
```swift
let leadingItem = Button(action: {...}) {Image(systemName: "...")}
let trailingItem = Button(action: {...}) {Image(systemName: "...")}

return NavigationView {
  ...
    .navigationBarItems(leading: leadingItem, trailing: trailingItem)
}
```

- 내비게이션 링크(NavigationLink) : 지정한 목적지로 이동할 수 있도록 만들어진 버튼
```swift
NavigationView {
  NavigationLink(destination: 이동하고자하는_뷰) {
    Image("SwiftUI")
  }
  .navigationTitle("내비게이션 링크")
}
```

- 내비게이션 바 히든(NavigationBarHidden) : 내비게이션 바 또는 뒤로가기 버튼 숨기기
```swift
NavigationView {
  ...
    .navigationBarHidden(true)
}
```
```swift
let destination = Text("Destination View")
  .navigationBarButtonHidden(true)

return NavigationView {
  NavigationLink(destination: destination) {
    Image("SwiftUI").renderingMode(.original)
  }
  .navigationBarTitle("내비게이션 바 백버튼 히든")
}
```

- NavigationViewStyle
  + Default
  + Stack
  + DoubleColumn
```swift
NavigationView { ... }
  .navigationViewStyle(StackNavigationViewStyle)  // 스타일 지정
```

### List
하나의 열에 여러 개의 행으로 표현되는 UI를 구성하는 뷰 (= UITableView)

- 정적 콘텐츠

- 동적 콘텐츠
  + Range<Int>
    ```swift
    // Half-Open Range Oparator만 사용 가능
    List(0..<100) {
      Text("\($0)")
    }
    ```
  + RandomAcessCollection
    - id 식별자 지정 (Hashable 프로토콜을 준수하는 경우 self 입력 가능, 기본 타입 대부분이 준수)
    ```swift
    List(["A", "B", "C", "D", "E"], id: \.self) { ... }

    struct User: Hashable { ... }
    List([User(name: "steve"), User(name: "James")], id: \.name) { ... }
    ```
    - identifiable 프로토콜 채택
    ```swift
    struct Animal: Identifiable {
      let id = UUID()  // id의 타입은 UUID 외에도 Hashable을 준수하는 모든 타입 사용 가능
      ...
    }

    List([Animal(name: "Tory"), Animal(name: "Lilly")]) { ... }  // id 생략
    ```

- ForEach를 활용하여 정적, 동적 컨텐츠 조합 가능

- Section
```swift
let fruits = ["Apple", "Banana", "Peach"]
let drinks = ["Coke", "Water", "Juice"]

let titles = ["Fruits", "Drinks"]
let data = [fruits, drinks]

List {
  ForEach(data.indices) { index in
    Section(
      header: Text(titles[index]).font(.title),
      footer: HStack { Spacer(); Text("\(data[index].count)건") }
    ) {
        ForEach(data[index], id: \.self) {
          Text($0)
        }
    }
  }
}
```

- ListStyle
  + DefaultList
  + PlainList
  + GroupedList

### TabView

### @State, @Binding

### @EnvironmentObject

### UIViewController, UIView 호환 